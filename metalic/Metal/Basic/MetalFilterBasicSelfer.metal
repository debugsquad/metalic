#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kTopLightThreshold = 0.9;
static constant float kMidLightThreshold = 0.7;
static constant float kTopBrightness = 0.66;
static constant float kMidBrightness = 0.7;
static constant float kMinBrightness = 0.3;
static constant float kBrightness = 1;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_basicSelfer(texture2d<float, access::read> originalTexture [[texture(0)]],
                texture2d<float, access::write> filteredTexture [[texture(1)]],
                uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float gridColorRed = gridColor[0];
    float gridColorGreen = gridColor[1];
    float gridColorBlue = gridColor[2];
    float lightValue = dot(gridColor.rgb, kLightScale);
    float newColorRed;
    float newColorGreen;
    float newColorBlue;
    float brightness;
    float4 outColor;
    
    if (lightValue >= kTopLightThreshold)
    {
        brightness = kTopBrightness;
    }
    else if (lightValue >= kMidLightThreshold)
    {
        brightness = kMidBrightness;
    }
    else
    {
        brightness = kMinBrightness;
    }
    
    newColorRed = gridColorRed * brightness;
    newColorGreen = gridColorGreen * brightness;
    newColorBlue = gridColorBlue * brightness;
    
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
