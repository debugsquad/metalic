#include <metal_stdlib>
using namespace metal;

static constant float kBrightness = 1;
static constant float kMinColor = 0;
static constant float kMaxColor = 1;

kernel void
filter_basicChalk(texture2d<float, access::read> originalTexture [[texture(0)]],
                  texture2d<float, access::write> filteredTexture [[texture(1)]],
                  uint2 gridId [[thread_position_in_grid]])
{
    
}
