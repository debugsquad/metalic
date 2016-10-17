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
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.scaleAspectFill
        autoResizeDrawable = false
    }
    
    override func draw()
    {
        guard
        
            let metalFitlerType:MetalFilter.Type = controller.viewHome.viewMenu.selectedItem?.filter,
            let drawable:CAMetalDrawable = currentDrawable,
            let sourceTexture:MTLTexture = controller.sourceTexture
        
        else
        {
            return
        }
        
        let destinationTexture:MTLTexture = drawable.texture
        let commandBuffer:MTLCommandBuffer = controller.commandQueue.makeCommandBuffer()
        let metalFilter:MetalFilter = metalFitlerType.init(device:controller.device)
        
        metalFilter.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        super.draw()
    }
}
