import MetalPerformanceShaders

class MetalFilter:MPSUnaryImageKernel
{
    let mtlFunction:MTLFunction
    private let kThreadgroupWidth:Int = 2
    private let kThreadgroupHeight:Int = 2
    private let kThreadgroupDeep:Int = 1
    
    init(device:MTLDevice, functionName:String)
    {
        let mtlLibrary:MTLLibrary = device.newDefaultLibrary()!
        mtlFunction = mtlLibrary.makeFunction(name:functionName)!
        
        super.init(device:device)
    }
    
    required override init(device:MTLDevice)
    {
        fatalError()
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        let optionalPipeline:MTLComputePipelineState?
        
        do
        {
            try optionalPipeline = device.makeComputePipelineState(function:mtlFunction)
        }
        catch
        {
            optionalPipeline = nil
        }
        
        guard
        
            let pipeline:MTLComputePipelineState = optionalPipeline
        
        else
        {
            return
        }
        
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        let threadgroupsHorizontal:Int = sourceWidth / kThreadgroupWidth
        let threadgroupsVertical:Int = sourceHeight / kThreadgroupHeight
        let threadgroupCounts:MTLSize = MTLSizeMake(
            kThreadgroupWidth,
            kThreadgroupHeight,
            kThreadgroupDeep)
        let threadgroups:MTLSize = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            1)
        
        let commandEncoder:MTLComputeCommandEncoder = commandBuffer.makeComputeCommandEncoder()
        commandEncoder.setComputePipelineState(pipeline)
        commandEncoder.setTexture(sourceTexture, at:0)
        commandEncoder.setTexture(destinationTexture, at:1)
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
    }
    
    //MARK: public
    
    func specialConfig()
    {
    }
}
