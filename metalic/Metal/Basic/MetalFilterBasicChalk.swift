import MetalPerformanceShaders

class MetalFilterBasicChalk:MetalFilter
{
    private let sobelFilter:MPSImageSobel
    private let kFunctionName:String = "filter_basicChalk"
    
    required init(device:MTLDevice)
    {
        sobelFilter = MPSImageSobel(device:device)
        sobelFilter.edgeMode = MPSImageEdgeMode.zero
        
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        sobelFilter.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
        
        super.encode(
            commandBuffer:commandBuffer,
            sourceTexture:destinationTexture,
            destinationTexture:destinationTexture)
    }
}
