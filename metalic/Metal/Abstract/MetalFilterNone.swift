import MetalPerformanceShaders

class MetalFilterNone:MetalFilter
{
    private let kDepth:Int = 1
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        let width:Int = sourceTexture.width
        let height:Int = sourceTexture.height
        let origin:MTLOrigin = MTLOriginMake(0, 0, 0)
        let size:MTLSize = MTLSizeMake(width, height, kDepth)
        let blitEncoder:MTLBlitCommandEncoder = commandBuffer.makeBlitCommandEncoder()
        
        blitEncoder.copy(
            from:sourceTexture,
            sourceSlice:0,
            sourceLevel:0,
            sourceOrigin:origin,
            sourceSize:size,
            to:destinationTexture,
            destinationSlice:0,
            destinationLevel:0,
            destinationOrigin:origin)
        blitEncoder.endEncoding()
    }
}
