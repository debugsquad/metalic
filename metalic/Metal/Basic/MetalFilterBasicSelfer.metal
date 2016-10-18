#include <metal_stdlib>
using namespace metal;

kernel void
filter_basicSelfer(texture2d<float, access::read> originalTexture [[texture(0)]],
                   texture2d<float, access::write> filteredTexture [[texture(1)]],
                   texture2d<float, access::read> facesTexture [[texture(2)]],
                   texture2d<float, access::read> bokehTexture [[texture(3)]],
                   uint2 gridId [[thread_position_in_grid]])
{
    float4 originalColor = originalTexture.read(gridId);
    float4 facesColor = facesTexture.read(gridId);
    float4 bokehColor = bokehTexture.read(gridId);
    float4 outColor;
    
    if (facesColor[0] == 0)
    {
        outColor = bokehColor;
    }
    else
    {
        outColor = originalColor;
    }
    
    filteredTexture.write(outColor, gridId);
}
