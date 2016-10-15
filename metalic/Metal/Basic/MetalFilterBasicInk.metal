#include <metal_stdlib>
using namespace metal;

kernel void
filter_basicInk(texture2d<float, access::read> originalTexture [[texture(0)]],
                texture2d<float, access::write> filteredTexture [[texture(1)]],
                uint2 gridId [[thread_position_in_grid]])
{
     float4 gridColor = originalTexture.read(gridId);
     float value = dot(gridColor.rgb, float3(0.299, 0.587, 0.114));
     float bright;
     
     if (value >= 0.9)
     {
         bright = 0.66;
     }
     else if (value >= 0.5)
     {
         bright = 0.7;
     }
     else
     {
         bright = 0.3;
     }
     
     float4 outColor(inColor[0] * bright, inColor[1] * bright, inColor[2] * bright, bright);
     outTexture.write(outColor, gid);
}
