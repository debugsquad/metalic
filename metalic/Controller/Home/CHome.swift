import UIKit
import MetalKit

class CHome:CController
{
    weak var viewHome:VHome!
    
    let device = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue!
    var sourceTexture: MTLTexture?
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMetal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewHome.viewPicture.draw()
    }
    
    //MARK: private
    
    private func setupMetal() {
        commandQueue = device.makeCommandQueue()
        
        /** MetalPerformanceShaders is a compute-based framework.
         This means that the drawable's texture is *written* to, not *rendered* to.
         The destination texture for all image filter operations is not a traditional framebuffer.
         */
        viewHome.viewPicture.framebufferOnly = false
        
        /** This sample manages the MTKView's draw loop manually (i.e. the draw() method is called explicitly).
         For the still image, the content only needs to be filtered once.
         For the video image, the content only needs to be filtered whenever the camera provides a new video frame.
         */
        viewHome.viewPicture.isPaused = true
        viewHome.viewPicture.delegate = self
        viewHome.viewPicture.device = device
        viewHome.viewPicture.colorPixelFormat = .bgra8Unorm
    }
    
    //MARK: public
    
    func imageSelected(image:UIImage?)
    {
        sourceTexture = nil
        
        let loader = MTKTextureLoader(device: device)
        let cgImage = image?.cgImage
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
            let fileTexture = try loader.newTexture(with: cgImage!, options: options as [String : NSObject]?)
            sourceTexture = fileTexture
        } catch let error as NSError {
            print("Error loading still image texture: \(error)")
        }
        
        viewHome.viewPicture.draw()
    }
}
