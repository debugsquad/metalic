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
    }
    
    override func draw() {
        
        guard
            
            let drawable:CAMetalDrawable = currentDrawable,
            let sourceTexture = controller.sourceTexture
            
        else
        {
            return
        }
        
        let commandBuffer = controller.commandQueue.makeCommandBuffer();
        
        let imageFilter: CommandBufferEncodable = GaussianBlur(device:controller.device)
        
        
        /** Obtain the current drawable.
         The final destination texture is always the filtered output image written to the MTKView's drawable.
         */
        let destinationTexture = drawable.texture
        
        // Encode the image filter operation.
        imageFilter.encode(to: commandBuffer,
                           sourceTexture: sourceTexture,
                           destinationTexture: destinationTexture)
        
        
        // Schedule a presentation.
        commandBuffer.present(drawable)
        
        // Commit the command buffer to the GPU.
        commandBuffer.commit()
        
        super.draw()
    }
}
