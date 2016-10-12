import Foundation
import MetalPerformanceShaders

class MBasicA:MPSUnaryImageKernel
{
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture)
    {
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.makeFunction(name:"adjust_saturation")
        let pipeline:MTLComputePipelineState?
        
        do
        {
            try pipeline = device.makeComputePipelineState(function:fragmentProgram!)
        }
        catch
        {
            pipeline = nil
        }
        
        let threadgroupCounts = MTLSizeMake(8, 8, 1)
        let threadgroups = MTLSizeMake(sourceTexture.width / threadgroupCounts.width, sourceTexture.height / threadgroupCounts.height, 1)
        
        let commandEncoder = commandBuffer.makeComputeCommandEncoder()
     
        commandEncoder.setComputePipelineState(pipeline!)
        commandEncoder.setTexture(sourceTexture, at:0)
        commandEncoder.setTexture(destinationTexture, at:1)
        commandEncoder.dispatchThreadgroups(threadgroups, threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
        
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}
