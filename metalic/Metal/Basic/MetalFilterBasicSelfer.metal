#include <metal_stdlib>
using namespace metal;

static constant float kBrightness = 1;
static constant float kBlurSize = 8;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;
static constant float kBrightnessNotFace = 0.9;

kernel void
filter_basicSelfer(texture2d<float, access::read> originalTexture [[texture(0)]],
                   texture2d<float, access::write> filteredTexture [[texture(1)]],
                   texture2d<float, access::read> facesTexture [[texture(2)]],
                   uint2 gridId [[thread_position_in_grid]])
{
    float4 gridColor = originalTexture.read(gridId);
    float4 facesColor = facesTexture.read(gridId);
    float4 outColor;
    float newColorRed = gridColor[0];
    float newColorGreen = gridColor[1];
    float newColorBlue = gridColor[2];
    float brightness = kBrightness;
    bool applyBlur = false;
    
    if (facesColor[0] == 0)
    {
        applyBlur = true;
        brightness = kBrightnessNotFace
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
    
    newColorRed *= brightness;
    newColorGreen *= brightness;
    newColorBlue *= brightness;
    
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
