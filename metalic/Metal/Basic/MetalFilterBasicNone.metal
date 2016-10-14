#include <metal_stdlib>
using namespace metal;

kernel void filter_basicNone(texture2d<float, access::read> originalTexture [[texture(0)]],
                             texture2d<float, access::write> filteredTexture [[texture(1)]],
                             uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    filteredTexture.write(gridColor, gridId);
}
