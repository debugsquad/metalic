#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);
static constant float kBrightness = 1;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_basicChalk(texture2d<float, access::read> originalTexture [[texture(0)]],
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
    float4 outColor;
    
    if (lightValue == 0)
    {
        newColorRed = 1;
        newColorGreen = 1;
        newColorBlue = 1;
    }
    else
    {
        newColorRed = gridColorRed;
        newColorGreen = gridColorGreen;
        newColorBlue = gridColorBlue;
    }
    
    outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
    filteredTexture.write(outColor, gridId);
}
