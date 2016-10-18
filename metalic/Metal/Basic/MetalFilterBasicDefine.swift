import MetalPerformanceShaders

class MetalFilterBasicDefine:MetalFilter
{
    private let kMinCenter:Float = 5
    private let kMinCorners:Float = -1
    private let kSizeDivider:Float = 144
    private let kCornersDivider:Float = -5
    private let kMinImageSize:Int = 640
    private let kKernelSize:Int = 3
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        let minSize:Int = min(sourceWidth, sourceHeight)
        let center:Float
        let corners:Float
        
        if minSize >= kMinImageSize
        {
            let minSizeFloat:Float = Float(minSize)
            center = ceilf(minSizeFloat / kSizeDivider)
            corners = floor(center / kCornersDivider)
        }
        else
        {
            center = kMinCenter
            corners = kMinCorners
        }
        
        let weights:[Float] = [
            corners, 0, corners,
            corners, center, 0,
            corners, 0, corners
        ]
        
        let convolution:MPSImageConvolution = MPSImageConvolution(
            device:device,
            kernelWidth:kKernelSize,
            kernelHeight:kKernelSize,
            weights:weights)
        convolution.edgeMode = MPSImageEdgeMode.zero
        convolution.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
    }
}
