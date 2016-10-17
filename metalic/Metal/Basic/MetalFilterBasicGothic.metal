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
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_basicGothic(texture2d<float, access::read> originalTexture [[texture(0)]],
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
    float newColorRed;
    float newColorGreen;
    float newColorBlue;
    
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
            newColorRed = gridColorRed * kMinThresholdMult;
            newColorGreen = gridColorGreen * kMinThresholdMult;
            newColorBlue = gridColorBlue * kMinThresholdMult;
        }
        else if (lightValue > kTopLightThreshold)
        {
            newColorRed = gridColorRed * kTopThresholdMultRed;
            newColorGreen = gridColorGreen * kTopThresholdMultGreen;
            newColorBlue = gridColorBlue * kTopThresholdMultBlue;
        }
        else
        {
            applyBlur = true;
        }
    }
    else if (mainlyBlue)
    {
        newColorRed = gridColorRed * kTopThresholdBlueMultRed;
        newColorGreen = gridColorGreen * kTopThresholdBlueMultGreen;
        newColorBlue = gridColorBlue * kTopThresholdBlueMultBlue;
    }
    else if (mainlyRed)
    {
        if (ultraRedish)
        {
            newColorRed = gridColorRed * kTopThresholdRedishMultRed;
            newColorGreen = gridColorGreen * kTopThresholdRedishMultGreen;
            newColorBlue = gridColorBlue * kTopThresholdRedishMultBlue;
        }
        else
        {
            newColorRed = gridColorRed * kTopThresholdRedMultRed;
            newColorGreen = gridColorGreen * kTopThresholdRedMultGreen;
            newColorBlue = gridColorBlue * kTopThresholdRedMultBlue;
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
        newColorRed = sumColor[0];
        newColorGreen = sumColor[1];
        newColorBlue = sumColor[2];
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
