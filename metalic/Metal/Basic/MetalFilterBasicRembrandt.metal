#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kAlmostWhite = 0.96;
static constant float kTopLightThreshold = 0.9;
static constant float kMinLightThreshold = 0.3;
static constant float kMinDeltaColor = 0.1;
static constant float kRedGreenDeltaColor = 0.4;
static constant float kMinThresholdMult = 0.4;
static constant float kTopThresholdMultRed = 0.98;
static constant float kTopThresholdMultGreen = 0.99;
static constant float kTopThresholdMultBlue = 1;
static constant float kTopThresholdBlueMultRed = 1;
static constant float kTopThresholdBlueMultGreen = 1.5;
static constant float kTopThresholdBlueMultBlue = 2;
static constant float kTopThresholdRedishMultRed = 1.8;
static constant float kTopThresholdRedishMultGreen = 1.1;
static constant float kTopThresholdRedishMultBlue = 1;
static constant float kTopThresholdRedMultRed = 1;
static constant float kTopThresholdRedMultGreen = 1.2;
static constant float kTopThresholdRedMultBlue = 1.5;
static constant float kBrightness = 1;
static constant float kBlurSize = 12;

kernel void
filter_basicRembrandt(texture2d<float, access::read> originalTexture [[texture(0)]],
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
    bool mainlyRed = false;
    bool ultraRedish = false;
    
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
    
    if (gridColorRed >= gridColorBlue && gridColorRed >= gridColorGreen)
    {
        mainlyRed = true;
        
        if (deltaColorRedGreen > kRedGreenDeltaColor)
        {
            ultraRedish = true;
        }
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
        float newColorRed = gridColorRed * kTopThresholdBlueMultRed;
        float newColorGreen = gridColorGreen * kTopThresholdBlueMultGreen;
        float newColorBlue = gridColorBlue = kTopThresholdBlueMultBlue;
        outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
    }
    else if (mainlyRed)
    {
        if (ultraRedish)
        {
            float newColorRed = gridColorRed * kTopThresholdRedishMultRed;
            float newColorGreen = gridColorGreen * kTopThresholdRedishMultGreen;
            float newColorBlue = gridColorBlue = kTopThresholdRedishMultBlue;
            outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
        }
        else
        {
            float newColorRed = gridColorRed * kTopThresholdRedMultRed;
            float newColorGreen = gridColorGreen * kTopThresholdRedMultGreen;
            float newColorBlue = gridColorBlue = kTopThresholdRedMultBlue;
            outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
        }
    }
    else
    {
        applyBlur = true;
    }
    
    if (applyBlur)
    {
        int size = kBlurSize;
        int radius = size / 2.0;
        float4 sumColor(0, 0, 0, 0);
        
        for (int indexVertical = 0; indexVertical < size; ++indexVertical)
        {
            int indexVertical_radius = indexVertical - radius;
            
            for (int indexHorizontal = 0; indexHorizontal < size; ++indexHorizontal)
            {
                int indexHorizontal_radius = indexHorizontal - radius;
                int radIndexX = gridId.x + indexHorizontal_radius;
                int radIndexY = gridId.y + indexVertical_radius;
                
                uint2 textureIndex(radIndexX, radIndexY);
                float4 averageColor = originalTexture.read(textureIndex).rgba;
                sumColor += averageColor;
            }
        }
        
        sumColor /= (size * size);
        outColor = float4(sumColor.rgb, 1);
    }
    
    filteredTexture.write(outColor, gridId);
}
