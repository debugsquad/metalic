import UIKit
import MetalKit

class VHomeFilteredPicture:MTKView
{
    weak var controller:CHomeFiltered!
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.scaleAspectFill
        autoResizeDrawable = false
        framebufferOnly = false
        isPaused = true
        colorPixelFormat = MTLPixelFormat.bgra8Unorm
    }
    
    override func draw()
    {
        guard
            
            let drawable:CAMetalDrawable = currentDrawable
            
            else
        {
            return
        }
        
        let destinationTexture:MTLTexture = drawable.texture
        let commandBuffer:MTLCommandBuffer = controller.home.commandQueue.makeCommandBuffer()
        
        controller.filter.encode(
            commandBuffer:commandBuffer,
            sourceTexture:controller.texture,
            destinationTexture:destinationTexture)
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        super.draw()
    }
}
