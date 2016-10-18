import MetalPerformanceShaders

class MetalFilterBasicDefine:MetalFilter
{
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        print("\(sourceTexture.width) \(sourceTexture.height)")
        
        let weights: [Float] = [
            -1,  0,  -1,
            0,  5,  0,
            -1,  0,  -1
        ]
        
        let convolution = MPSImageConvolution(device: device,
                                              kernelWidth: 3,
                                              kernelHeight: 3,
                                              weights: weights)
        
        convolution.edgeMode = .zero
        
        convolution.encode(commandBuffer: commandBuffer,
                           sourceTexture: sourceTexture,
                           destinationTexture: destinationTexture)
    }
}
