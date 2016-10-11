import MetalKit

/// Uses the MetalKit texture loader to load a still image into a Metal texture.
class StillImageTextureProvider: NSObject {
    /// The source texture for image filter operations.
    var texture: MTLTexture?
    
    /// Returns an initialized StillImageTextureProvider object with a source texture, or nil in case of failure.
    required init?(device: MTLDevice, imageData: UIImage?) {
        super.init()
        
        let loader = MTKTextureLoader(device: device)
        let image = imageData?.cgImage
        // The still image is loaded directly into GPU-accessible memory that is only ever read from.
        
        var options = [
            
            MTKTextureLoaderOptionTextureUsage:         MTLTextureUsage.shaderRead.rawValue,
            MTKTextureLoaderOptionSRGB:                 0
        ]
        
        if #available(iOS 10.0, *)
        {
            options[MTKTextureLoaderOptionTextureStorageMode] = MTLStorageMode.private.rawValue
        }
        
        do {
            let fileTexture = try loader.newTexture(with: image!, options: options as [String : NSObject]?)
            texture = fileTexture
        } catch let error as NSError {
            print("Error loading still image texture: \(error)")
            return nil
        }
    }
}
