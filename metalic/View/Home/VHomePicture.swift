import UIKit
import MetalKit

class VHomePicture:MTKView
{
    weak var controller:CHome!

    convenience init(controller:CHome)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        isUserInteractionEnabled = false
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
            
            let sourceTexture:MTLTexture = controller.sourceTexture
        
        else
        {
            return
        }
        
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        drawableSize = CGSize(width:sourceWidth, height:sourceHeight)
        
        guard
        
            let drawable:CAMetalDrawable = currentDrawable
        
        else
        {
            return
        }
        
        let destinationTexture:MTLTexture = drawable.texture
        let commandBuffer:MTLCommandBuffer = controller.commandQueue.makeCommandBuffer()
        
        filterTexture(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        super.draw()
    }
    
    //MARK: public
    
    func filterTexture(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        guard
            
            let metalFitlerType:MetalFilter.Type = controller.viewHome.viewMenu.selectedItem?.filter
            
        else
        {
            return
        }
        
        let metalFilter:MetalFilter = metalFitlerType.init(device:controller.device)
        
        metalFilter.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
    }
}
