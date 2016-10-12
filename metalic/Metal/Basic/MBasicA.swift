import Foundation
import MetalPerformanceShaders

class MBasicA:MPSUnaryImageKernel
{
    let vertexData:[Float] = [
        0.5]
    
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
        
        let sourceWidth = sourceTexture.width
        let sourceHeight = sourceTexture.height
        
        let threadgroupCounts = MTLSizeMake(2, 2, 1)
        let threadgroups = MTLSizeMake(sourceTexture.width / threadgroupCounts.width, sourceTexture.height / threadgroupCounts.height, 1)
        
        let vertexxSize = MemoryLayout.size(ofValue:Float.self)
        let buffer = device.makeBuffer(bytes:vertexData, length:vertexxSize, options: MTLResourceOptions.cpuCacheModeWriteCombined)
        let commandEncoder = commandBuffer.makeComputeCommandEncoder()
     
        commandEncoder.setComputePipelineState(pipeline!)
        commandEncoder.setTexture(sourceTexture, at:0)
        commandEncoder.setTexture(destinationTexture, at:1)
        commandEncoder.setBuffer(buffer, offset: 0, at: 0)
        commandEncoder.dispatchThreadgroups(threadgroups, threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
    }
}
