#include <metal_stdlib>
using namespace metal;

static constant float kBrightness = 1;
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
    float newColorRed = kMaxColor - gridColorRed;
    float newColorGreen = kMaxColor - gridColorGreen;
    float newColorBlue = kMaxColor - gridColorBlue;
    float4 outColor = float4(newColorRed, newColorGreen, newColorBlue, kBrightness);
    filteredTexture.write(outColor, gridId);
}
