import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    let weights: [Float] = [
        4,  0,  0,
        0,  1,  0,
        0,  0,  -4
    ]
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
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
