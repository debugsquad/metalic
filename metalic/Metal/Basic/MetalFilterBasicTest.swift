import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    private let kFunctionName:String = "filter_basicComic"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        let blitCommandEncoder = commandBuffer.makeBlitCommandEncoder()
        blitCommandEncoder.copy(from: sourceTexture,
                                sourceSlice: 0,
                                sourceLevel: 0,
                                sourceOrigin: MTLOriginMake(0, 0, 0),
                                sourceSize: MTLSizeMake(sourceTexture.width, sourceTexture.height, 1),
                                to: destinationTexture,
                                destinationSlice: 0,
                                destinationLevel: 0,
                                destinationOrigin: MTLOriginMake(0, 0, 0))
        blitCommandEncoder.endEncoding()
    }
}
