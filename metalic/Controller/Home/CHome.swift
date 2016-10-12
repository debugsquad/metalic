import UIKit
import MetalKit

class CHome:CController
{
    weak var viewHome:VHome!
    var normalizedImage:UIImage?
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
    
    private func normalize(image:UIImage)
    {
        UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
        let rect = CGRect(origin:CGPoint.zero, size:image.size)
        image.draw(in:rect)
        normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
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
        viewHome.viewPicture.device = device
        viewHome.viewPicture.colorPixelFormat = .bgra8Unorm
    }
    
    //MARK: public
    
    func imageSelected(image:UIImage?)
    {
        if image != nil
        {
            
            
            
            
            let cgImage = retVal.cgImage!
            
            let scale = UIScreen.main.scale
            let width = viewHome.viewPicture.bounds.width * scale
            let height = viewHome.viewPicture.bounds.height * scale
            let bitsPerComponent = cgImage.bitsPerComponent
            let bytesPerRow = cgImage.bytesPerRow
            let colorSpace = cgImage.colorSpace
            let bitmapInfo = cgImage.bitmapInfo
            let context = CGContext.init(data:nil, width:Int(width), height:Int(height), bitsPerComponent:bitsPerComponent, bytesPerRow:bytesPerRow, space:colorSpace!, bitmapInfo:bitmapInfo.rawValue)
            
            
            
            
            context?.interpolationQuality = CGInterpolationQuality.high
            context?.draw(cgImage, in:CGRect(origin:CGPoint.zero, size:CGSize(width:width, height:height)))
            
            let scaledImage:CGImage? = context?.makeImage()
            
            sourceTexture = nil
            
            let loader = MTKTextureLoader(device: device)
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
                let fileTexture = try loader.newTexture(with: scaledImage!, options: options as [String : NSObject]?)
                sourceTexture = fileTexture
            } catch let error as NSError {
                print("Error loading still image texture: \(error)")
            }
            
            viewHome.viewPicture.draw()
        }
    }
}
