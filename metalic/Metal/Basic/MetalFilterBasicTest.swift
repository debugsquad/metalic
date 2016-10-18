import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    let dilate: MPSImageDilate
    let bokehRadius = 40
    
    required init(device:MTLDevice)
    {
        var probe = [Float]()
        let size = bokehRadius * 2 + 1
        let mid = Float(size) / 2
        
        for i in 0 ..< size
        {
            for j in 0 ..< size
            {
                let x = abs(Float(i) - mid)
                let y = abs(Float(j) - mid)
                let element: Float = hypot(x, y) < Float(self.bokehRadius) ? 0.0 : 1.0
                probe.append(element)
            }
        }
        
        dilate = MPSImageDilate(
            device: device,
            kernelWidth: size,
            kernelHeight: size,
            values: probe)
        
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        print("\(sourceTexture.width) \(sourceTexture.height)")
        
        dilate.encode(commandBuffer: commandBuffer,
                      sourceTexture: sourceTexture,
                      destinationTexture: destinationTexture)
    }
}
