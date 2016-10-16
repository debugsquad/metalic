#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kMinDeltaColor = 0.1;
static constant float kRedGreenDeltaColor = 0.4;
static constant float kBrightnessRedish = 1.3;
static constant float kBrightnessRed = 1.1;
static constant float kBrightnessPlainLight = 0.9;
static constant float kBrightnessPlainDark = 0.3;
static constant float kThresholdLight = 0.94;
static constant float kThresholdDark = 0.4;
static constant float kBrightness = 1;

kernel void
filter_basicRembrandt(texture2d<float, access::read> originalTexture [[texture(0)]],
                      texture2d<float, access::write> filteredTexture [[texture(1)]],
                      uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float gridColorRed = gridColor[0];
    float gridColorGreen = gridColor[1];
    float gridColorBlue = gridColor[2];
    float lightValue = dot(gridColor.rgb, kLightScale);
    float deltaColorRedGreen = abs(gridColorRed - gridColorGreen);
    float deltaColorGreenBlue = abs(gridColorGreen - gridColorBlue);
    float deltaColorBlueRed = abs(gridColorBlue - gridColorRed);
    float brightness = 1;
    bool plainColor = false;
    bool mainlyRed = false;
    bool ultraRedish = false;
    float newColorRed;
    float newColorGreen;
    float newColorBlue;
    float4 outColor;
    
    if (gridColorRed >= gridColorBlue && gridColorRed >= gridColorGreen)
    {
        mainlyRed = true;
        
        if (deltaColorRedGreen > kRedGreenDeltaColor)
        {
            ultraRedish = true;
        }
    }
    
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
    
    if (mainlyRed)
    {
        if (ultraRedish)
        {
            brightness = kBrightnessRedish;
        }
        else
        {
            brightness = kBrightnessRed;
        }
    }
    else if (plainColor)
    {
        if (lightValue >= kThresholdLight)
        {
            brightness = kBrightnessPlainLight;
        }
        else if (lightValue <= kThresholdDark)
        {
            brightness = kBrightnessPlainDark;
        }
    }
    
    newColorRed = gridColorRed * brightness;
    newColorGreen = gridColorGreen * brightness;
    newColorBlue = gridColorBlue * brightness;
    outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
    filteredTexture.write(outColor, gridId);
}
