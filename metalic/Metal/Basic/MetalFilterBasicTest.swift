import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    var histogramInfo = MPSImageHistogramInfo(
        numberOfHistogramEntries: 256,
        histogramForAlpha: false,
        minPixelValue: vector_float4(0,0,0,0),
        maxPixelValue: vector_float4(0.5,0.32,0.2,1))
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        print("\(sourceTexture.width) \(sourceTexture.height)")
        
        let calculation = MPSImageHistogram(device: device,
                                        histogramInfo: &histogramInfo)
        
        let equalization = MPSImageHistogramEqualization(device: device,
                                                     histogramInfo: &histogramInfo)
        
        
        let bufferLength = calculation.histogramSize(forSourceFormat: sourceTexture.pixelFormat)
        let histogramInfoBuffer = device.makeBuffer(length: bufferLength, options: [.storageModePrivate])
        print("Equalization Buffer Length: \(bufferLength)")
        
        // Performing equalization with MPS is a three stage operation:
        
        // 1: The image's histogram is calculated and passed to an MPSImageHistogramInfo object.
        calculation.encode(to: commandBuffer,
                           sourceTexture: sourceTexture,
                           histogram: histogramInfoBuffer,
                           histogramOffset: 0)
        
        // 2: The equalization filter's encodeTransform method creates an image transform which is used to equalize the distribution of the histogram of the source image.
        equalization.encodeTransform(to: commandBuffer,
                                     sourceTexture: sourceTexture,
                                     histogram: histogramInfoBuffer,
                                     histogramOffset: 0)
        
        // 3: The equalization filter's encode method applies the equalization transform to the source texture and and writes the output to the destination texture.
        equalization.encode(commandBuffer: commandBuffer,
                            sourceTexture: sourceTexture,
                            destinationTexture: destinationTexture)
    }
}
