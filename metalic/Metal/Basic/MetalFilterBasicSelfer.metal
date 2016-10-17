#include <metal_stdlib>
using namespace metal;

static constant float3 kLightScale(0.299, 0.587, 0.114);

kernel void
filter_basicSelfer(texture2d<float, access::read> originalTexture [[texture(0)]],
                   texture2d<float, access::write> filteredTexture [[texture(1)]],
                   texture2d<float, access::read> facesTexture [[texture(2)]],
                   uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float4 facesColor = facesTexture.read(gridId);
    float4 outColor;
    
    if (facesColor[0] != 0)
    {
        outColor = float4(1, 0, 0, 1);
    }
    else
    {
        outColor = gridColor;
    }
    
    filteredTexture.write(outColor, gridId);
}
