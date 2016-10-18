#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kRedGreenDeltaColor = 0.4;
static constant float kMinDeltaColor = 0.06;
static constant float kBrightness = 1;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_basicComic(texture2d<float, access::read> originalTexture [[texture(0)]],
                  texture2d<float, access::write> filteredTexture [[texture(1)]],
                  uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float lightValue = dot(gridColor.rgb, kLightScale);
    float gridColorRed = gridColor[0];
    float gridColorGreen = gridColor[1];
    float gridColorBlue = gridColor[2];
    float deltaColorRedGreen = abs(gridColorRed - gridColorGreen);
    float deltaColorGreenBlue = abs(gridColorGreen - gridColorBlue);
    float deltaColorBlueRed = abs(gridColorBlue - gridColorRed);
    float newColorRed = gridColorRed;
    float newColorGreen = gridColorGreen;
    float newColorBlue = gridColorBlue;
    float4 outColor;
    bool plainColor = false;
    
    if (deltaColorRedGreen < kMinDeltaColor)
    {
        if (deltaColorGreenBlue < kMinDeltaColor)
        {
            if (deltaColorBlueRed < kMinDeltaColor)
            {
                plainColor = true;
            }
        }
    }
    
    if (plainColor)
    {
        if (lightValue > 0.6)
        {
            newColorRed = gridColorRed * 0.9;
            newColorGreen = gridColorGreen * 0.9;
            newColorBlue = gridColorBlue * 0.9;
        }
        else
        {
            newColorRed = gridColorRed * 0.5;
            newColorGreen = gridColorGreen * 0.5;
            newColorBlue = gridColorBlue * 0.5;
        }
    }
    else
    {
        if (gridColorBlue >= gridColorGreen &&  gridColorBlue >= gridColorRed)
        {
            newColorRed = gridColorRed * 0.8;
            newColorGreen = gridColorGreen * 1;
            newColorBlue = gridColorBlue * 1.2;
        }
        else if (gridColorRed >= gridColorBlue && gridColorRed >= gridColorGreen)
        {
            if (deltaColorRedGreen >= kRedGreenDeltaColor)
            {
                newColorRed = gridColorRed * 0.9;
                newColorGreen = gridColorGreen * 0.5;
                newColorBlue = gridColorBlue * 0.5;
            }
            else
            {
                if (deltaColorRedGreen >= deltaColorGreenBlue || lightValue > 0.6)
                {
                    newColorRed = gridColorRed * 1;
                    newColorGreen = gridColorGreen * 1.05;
                    newColorBlue = gridColorBlue * 1.1;
                }
                else
                {
                    newColorRed = gridColorRed * 0.8;
                    newColorGreen = gridColorGreen * 0.7;
                    newColorBlue = gridColorBlue * 0.6;
                }
            }
        }
        else
        {
            newColorRed = gridColorRed * 0.9;
            newColorGreen = gridColorGreen * 0.6;
            newColorBlue = gridColorBlue * 0.4;
        }
    }
    
    if (newColorRed > kMaxColor)
    {
        newColorRed = kMaxColor;
    }
    else if (newColorRed < kMinColor)
    {
        newColorRed = kMinColor;
    }
    
    if (newColorGreen > kMaxColor)
    {
        newColorGreen = kMaxColor;
    }
    else if (newColorGreen < kMinColor)
    {
        newColorGreen = kMinColor;
    }
    
    if (newColorBlue > kMaxColor)
    {
        newColorBlue = kMaxColor;
    }
    else if (newColorBlue < kMinColor)
    {
        newColorBlue = kMinColor;
    }
    
    outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
    filteredTexture.write(outColor, gridId);
}
