//
//  MetalFilterBasicInk.metal
//  metalic
//
//  Created by zero on 10/14/16.
//  Copyright © 2016 iturbide. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void filter_basicInk(texture2d<float, access::read> inTexture [[texture(0)]],
                              texture2d<float, access::write> outTexture [[texture(1)]],
                              const device float* saturationFactor [[buffer(0)]],
                              uint2 gid [[thread_position_in_grid]])
{
    /*
     
     Saturation
     float4 inColor = inTexture.read(gid);
     float value = dot(inColor.rgb, float3(0.299, 0.587, 0.114));
     float4 grayColor(value, value, value, 1.0);
     float4 outColor = mix(grayColor, inColor, 0.09);
     outTexture.write(outColor, gid);*/
    
    /*
     
     ink
     float4 inColor = inTexture.read(gid);
     float value = dot(inColor.rgb, float3(0.299, 0.587, 0.114));
     float bright;
     
     if (value >= 0.9)
     {
     bright = 0.66;
     }
     else if (value >= 0.5)
     {
     bright = 0.7;
     }
     else
     {
     bright = 0.3;
     }
     
     float4 outColor(inColor[0] * bright, inColor[1] * bright, inColor[2] * bright, bright);
     outTexture.write(outColor, gid);*/
    
    float minDelta = 0.1;
    float4 inColor = inTexture.read(gid);
    float4 outColor;
    float value = dot(inColor.rgb, float3(0.299, 0.587, 0.114));
    float red = inColor[0];
    float green = inColor[1];
    float blue = inColor[2];
    bool blur = false;
    outColor = inColor;
    
    float deltaRedGreen = abs(red - green);
    float deltaGreenBlue = abs(green - blue);
    float deltaBlueRed = abs(blue - red);
    bool plainColor = deltaRedGreen < minDelta && deltaGreenBlue < minDelta && deltaBlueRed < minDelta;
    
    if (plainColor)
    {
        if (value < 0.3)
        {
            outColor[0] = red * 0.4;
            outColor[1] = green * 0.4;
            outColor[2] = blue * 0.4;
        }
        else if (value > 0.9)
        {
            outColor[0] = red * 0.98;
            outColor[1] = green * 0.99;
            outColor[2] = blue * 1;
        }
        else
        {
            blur = true;
        }
    }
    else if (value > 0.96)
    {
        blur = true;
    }
    else if (blue >= red && blue >= green)
    {
        outColor[0] = red;
        outColor[1] = green * 1.5;
        outColor[2] = blue * 2;
    }
    else if (red >= green && red >= blue)
    {
        if (deltaRedGreen > 0.4)
        {
            outColor[0] = red * 1.8;
            outColor[1] = green * 1.1;
            outColor[2] = blue;
        }
        else
        {
            outColor[0] = red;
            outColor[1] = green * 1.2;
            outColor[2] = blue * 1.5;
        }
    }
    else
    {
        blur = true;
    }
    
    if (blur)
    {
        int size = 12;
        int radius = size / 2;
        
        float4 accumColor(0, 0, 0, 0);
        
        for (int j = 0; j < size; ++j)
        {
            for (int i = 0; i < size; ++i)
            {
                uint2 textureIndex(gid.x + (i - radius), gid.y + (j - radius));
                float4 color = inTexture.read(textureIndex).rgba;
                accumColor += color;
            }
        }
        
        accumColor /= (size * size);
        outColor = float4(accumColor.rgb, 1);
    }
    
    outTexture.write(outColor, gid);
}
