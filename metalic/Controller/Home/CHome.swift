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
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
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
        guard
        
            let image:UIImage = image
        
        else
        {
            return
        }
        
        normalize(image:image)
        
        guard
        
            let normalizedImage:UIImage = normalizedImage
        
        else
        {
            return
        }
        
        let imageWidth:CGFloat = normalizedImage.size.width
        let imageHeight:CGFloat = normalizedImage.size.height
        let drawWidth:Int
        let drawHeight:Int
        let drawX:Int
        let drawY:Int
        
        let cgImage = normalizedImage.cgImage!
        
        let scale = UIScreen.main.scale
        let width:CGFloat = viewHome.viewPicture.bounds.width * scale
        let height:CGFloat = viewHome.viewPicture.bounds.height * scale
        
        print("\(imageWidth) .. \(imageHeight)  \(width) ... \(height)")
        
        if width < imageWidth || height < imageHeight
        {
            let ratioWidth:CGFloat = imageWidth / width
            let ratioHeight:CGFloat = imageHeight / height
            let maxRatio:CGFloat = max(ratioWidth, ratioHeight)
            let scaledWidth:CGFloat = floor(imageWidth / maxRatio)
            let scaledHeight:CGFloat = floor(imageHeight / maxRatio)
            let deltaWidth:CGFloat = width - scaledWidth
            let deltaHeight:CGFloat = height - scaledHeight
            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
            drawX = Int(drawXFloat)
            drawY = Int(drawYFloat)
            drawWidth = Int(scaledWidth)
            drawHeight = Int(scaledHeight)
        }
        else
        {
            let deltaWidth:CGFloat = width - imageWidth
            let deltaHeight:CGFloat = height - imageHeight
            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
            drawX = Int(drawXFloat)
            drawY = Int(drawYFloat)
            drawWidth = Int(imageWidth)
            drawHeight = Int(imageHeight)
        }
        
        print("x:\(drawX) y:\(drawY) w:\(drawWidth), h:\(drawHeight)")
        
        let bitsPerComponent = cgImage.bitsPerComponent
        var bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        if bytesPerRow < 3000
        {
            bytesPerRow = 3000
        }
        
        let context = CGContext.init(data:nil, width:Int(width), height:Int(height), bitsPerComponent:bitsPerComponent, bytesPerRow:bytesPerRow, space:colorSpace!, bitmapInfo:bitmapInfo.rawValue)
        
        
        
        
        context?.interpolationQuality = CGInterpolationQuality.high
        context?.draw(cgImage, in:CGRect(x:drawX, y:drawY, width:drawWidth, height:drawHeight))
        
        guard
            
            let scaledImage = context?.makeImage()
        
        else
        {
            return
        }
        
        let loader = MTKTextureLoader(device: device)
        // The still image is loaded directly into GPU-accessible memory that is only ever read from.
        
        
        var options = [
            
            MTKTextureLoaderOptionTextureUsage:         MTLTextureUsage.shaderRead.rawValue
        ]
        
        if #available(iOS 10.0, *)
        {
            options[MTKTextureLoaderOptionTextureStorageMode] = MTLStorageMode.private.rawValue
        }
        
        do {
            let fileTexture = try loader.newTexture(with: scaledImage, options: options as [String : NSObject]?)
            sourceTexture = fileTexture
        } catch let error as NSError {
            print("Error loading still image texture: \(error)")
        }
        
        viewHome.viewPicture.draw()
    }
}
