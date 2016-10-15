#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kAlmostWhite = 0.96;
static constant float kTopLightThreshold = 0.9;
static constant float kMinLightThreshold = 0.3;
static constant float kMinDeltaColor = 0.1;
static constant float kMinThresholdMult = 0.4;
static constant float kTopThresholdMultRed = 0.98;
static constant float kTopThresholdMultGreen = 0.99;
static constant float kTopThresholdMultBlue = 1;
static constant float kBrightness = 1;

kernel void
filter_basicInk(texture2d<float, access::read> originalTexture [[texture(0)]],
                texture2d<float, access::write> filteredTexture [[texture(1)]],
                uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float4 outColor = gridColor;
    float gridColorRed = gridColor[0];
    float gridColorGreen = gridColor[1];
    float gridColorBlue = gridColor[2];
    float deltaColorRedGreen = abs(gridColorRed - gridColorGreen);
    float deltaColorGreenBlue = abs(gridColorGreen - gridColorBlue);
    float deltaColorBlueRed = abs(gridColorBlue - gridColorRed);
    float lightValue = dot(gridColor.rgb, kLightScale);
    bool applyBlur = false;
    bool plainColor = false;
    bool mainlyBlue = false;
    
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
    
    if (gridColorBlue >= gridColorRed && gridColorBlue >= gridColorGreen)
    {
        mainlyBlue = true;
    }
    
    if (lightValue > kAlmostWhite)
    {
        applyBlur = true;
    }
    else if (plainColor)
    {
        if (lightValue < kMinLightThreshold)
        {
            float newColorRed = gridColorRed * kMinThresholdMult;
            float newColorGreen = gridColorGreen * kMinThresholdMult;
            float newColorBlue = gridColorBlue = kMinThresholdMult;
            outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
        }
        else if (lightValue > kTopLightThreshold)
        {
            float newColorRed = gridColorRed * kTopThresholdMultRed;
            float newColorGreen = gridColorGreen * kTopThresholdMultGreen;
            float newColorBlue = gridColorBlue = kTopThresholdMultBlue;
            outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
        }
        else
        {
            applyBlur = true;
        }
    }
    else if (mainlyBlue)
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
