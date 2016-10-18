import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        let sobel = MPSImageSobel(device: device)
        sobel.edgeMode = .clamp
        sobel.encode(commandBuffer: commandBuffer,
                     sourceTexture: sourceTexture,
                     destinationTexture: destinationTexture)
    }
}
