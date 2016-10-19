#include <metal_stdlib>
using namespace metal;

static constant int kRadius = 30;

kernel void
filter_basicSelfer(texture2d<float, access::read> originalTexture [[texture(0)]],
                   texture2d<float, access::write> filteredTexture [[texture(1)]],
                   texture2d<float, access::read> facesTexture [[texture(2)]],
                   texture2d<float, access::read> bokehTexture [[texture(3)]],
                   uint2 gridId [[thread_position_in_grid]])
{
    float4 originalColor = originalTexture.read(gridId);
    float4 facesColor = facesTexture.read(gridId).rrrr;
    float4 bokehColor = bokehTexture.read(gridId);
    float4 outColor;
    
    if (facesColor[0] == 0.8)
    {
        outColor = float4(0,0,0,1);
        
        /*
        int radius;
        int gridX = gridId.x;
        int gridY = gridId.y;
        bool found = false;
        
        for (radius = 0; radius < kRadius; radius++)
        {
            int minX = gridX - radius;
            int minY = gridY - radius;
            int maxX = gridX + radius + 1;
            int maxY = gridY + radius + 1;
            
            for (int hr = minX; hr < maxX; hr++)
            {
                for (int vr = minY; vr < maxY; vr++)
                {
                    uint2 testIndex(hr, vr);
                    float4 testIndexColor = facesTexture.read(testIndex);
                    
                    if (testIndexColor[0] != 0)
                    {
                        vr = maxY;
                        hr = maxX;
                        found = true;
                    }
                }
            }
            
            if (found)
            {
                break;
            }
        }
        
        float mixRadius = radius / (float)kRadius;
        outColor = mix(originalColor, bokehColor, mixRadius);*/
    }
    else
    {
        outColor = originalColor;
    }
    
    filteredTexture.write(outColor, gridId);
}
