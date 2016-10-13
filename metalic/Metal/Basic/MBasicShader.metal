//
//  MBasicShader.metal
//  metalic
//
//  Created by zero on 10/11/16.
//  Copyright © 2016 iturbide. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 basic_vertex(                           // 1
                           const device packed_float3* vertex_array [[ buffer(0) ]], // 2
                           unsigned int vid [[ vertex_id ]]) {                 // 3
    return float4(vertex_array[vid], 1.0);              // 4
}

fragment half4 basic_fragment() { // 1
    return half4(0.3,0.5,0.7,0.5);              // 2
}


kernel void adjust_saturation(texture2d<float, access::read> inTexture [[texture(0)]],
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
    
    
    float4 inColor = inTexture.read(gid);
    float minMulti = 0.8;
    float midMulti = 0.9;
    float maxMulti = 1.1;
    float red = inColor[0];
    float green = inColor[1];
    float blue = inColor[2];
    float newRed;
    float newGreen;
    float newBlue;
    
    if (red >= green)
    {
        if (green >= blue)
        {
            newRed = red * maxMulti;
            green = green * midMulti;
            blue = blue * minMulti;
        }
        else if (blue >= red)
        {
            newRed = red * midMulti;
            green = green * minMulti;
            blue = blue * maxMulti;
        }
        else
        {
            newRed = red * maxMulti;
            green = green * minMulti;
            blue = blue * midMulti;
        }
    }
    else if (green >= blue)
    {
        if (blue >= red)
        {
            newRed = red * minMulti;
            green = green * maxMulti;
            blue = blue * midMulti;
        }
        else
        {
            newRed = red * midMulti;
            green = green * maxMulti;
            blue = blue * minMulti;
        }
    }
    else
    {
        newRed = red * minMulti;
        green = green * midMulti;
        blue = blue * maxMulti;
    }
    
    float4 outColor(newRed, newGreen, newBlue, 1.0);
    outTexture.write(outColor, gid);
}
