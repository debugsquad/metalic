import UIKit
import MetalKit

class CHome:CController
{
    weak var viewHome:VHome!
    var normalizedImage:UIImage?
    var normalizedScaledImage:CGImage?
    var device:MTLDevice!
    var commandQueue:MTLCommandQueue!
    var sourceTexture: MTLTexture?
    private let kMinBytesPerRow:Int = 3000
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupMetal()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewHome.viewPicture.draw()
    }
    
    //MARK: private
    
    private func setupMetal()
    {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
        viewHome.viewPicture.framebufferOnly = false
        viewHome.viewPicture.isPaused = true
        viewHome.viewPicture.device = device
        viewHome.viewPicture.colorPixelFormat = MTLPixelFormat.bgra8Unorm
    }
    
    private func normalize(image:UIImage, onCompletion:(() -> ())?)
    {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let rect = CGRect(origin:CGPoint.zero, size:image.size)
        image.draw(in:rect)
        normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        onCompletion?()
    }
    
    private func scaleImage(onCompletion:(() -> ())?)
    {
        guard
            
            let normalizedImage:UIImage = normalizedImage,
            let normalizedCGImage:CGImage = normalizedImage.cgImage
        
        else
        {
            return
        }
        
        let screenScale:CGFloat = UIScreen.main.scale
        let imageWidth:CGFloat = normalizedImage.size.width
        let imageHeight:CGFloat = normalizedImage.size.height
        let usableWidth:CGFloat = viewHome.viewPicture.bounds.width
        let usableHeight:CGFloat = viewHome.viewPicture.bounds.height
        let usableWidthScale:CGFloat = usableWidth * screenScale
        let usableHeightScale:CGFloat = usableHeight * screenScale
        let usableWidthScaleInt:Int = Int(usableWidthScale)
        let usableHeightScaleInt:Int = Int(usableHeightScale)
        let bitsPerComponent:Int = normalizedCGImage.bitsPerComponent
        let bitmapInfo:CGBitmapInfo = normalizedCGImage.bitmapInfo
        let colorSpace:CGColorSpace? = normalizedCGImage.colorSpace
        var bytesPerRow:Int = normalizedCGImage.bytesPerRow
        let drawRect:CGRect
        let drawWidth:Int
        let drawHeight:Int
        let drawX:Int
        let drawY:Int
        
        if usableWidthScale < imageWidth || usableHeightScale < imageHeight
        {
            let ratioWidth:CGFloat = imageWidth / usableWidthScale
            let ratioHeight:CGFloat = imageHeight / usableHeightScale
            let maxRatio:CGFloat = max(ratioWidth, ratioHeight)
            let scaledWidth:CGFloat = floor(imageWidth / maxRatio)
            let scaledHeight:CGFloat = floor(imageHeight / maxRatio)
            let deltaWidth:CGFloat = usableWidthScale - scaledWidth
            let deltaHeight:CGFloat = usableHeightScale - scaledHeight
            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
            drawX = Int(drawXFloat)
            drawY = Int(drawYFloat)
            drawWidth = Int(scaledWidth)
            drawHeight = Int(scaledHeight)
        }
        else
        {
            let deltaWidth:CGFloat = usableWidthScale - imageWidth
            let deltaHeight:CGFloat = usableHeightScale - imageHeight
            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
            drawX = Int(drawXFloat)
            drawY = Int(drawYFloat)
            drawWidth = Int(imageWidth)
            drawHeight = Int(imageHeight)
        }
        
        if bytesPerRow < kMinBytesPerRow
        {
            bytesPerRow = kMinBytesPerRow
        }
        
        drawRect = CGRect(x:drawX, y:drawY, width:drawWidth, height:drawHeight)
        
        guard
            
            let realColorSpace:CGColorSpace = colorSpace,
            let context:CGContext = CGContext.init(
                data:nil,
                width:usableWidthScaleInt,
                height:usableHeightScaleInt,
                bitsPerComponent:bitsPerComponent,
                bytesPerRow:bytesPerRow,
                space:realColorSpace,
                bitmapInfo:bitmapInfo.rawValue)
        
        else
        {
            return
        }
        
        context.interpolationQuality = CGInterpolationQuality.high
        context.draw(
            normalizedCGImage,
            in:drawRect)
        
        normalizedScaledImage = context.makeImage()
        onCompletion?()
    }
    
    private func textureWith(cgImage:CGImage) -> MTLTexture?
    {
        let mtlTexture:MTLTexture?
        let mtkTextureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        var options:[String:NSObject] = [
            MTKTextureLoaderOptionTextureUsage:MTLTextureUsage.shaderRead.rawValue as NSObject
        ]
        
        if #available(iOS 10.0, *)
        {
            options[MTKTextureLoaderOptionTextureStorageMode] = MTLStorageMode.private.rawValue as NSObject
        }
        
        do
        {
            mtlTexture = try mtkTextureLoader.newTexture(with:cgImage, options:options)
        }
        catch
        {
            mtlTexture = nil
        }
        
        return mtlTexture
    }
    
    private func loadTexture(onCompletion:(() -> ())?)
    {
        guard
            
            let scaledImage:CGImage = normalizedScaledImage
            
        else
        {
            return
        }
        
        sourceTexture = textureWith(cgImage:scaledImage)
        onCompletion?()
    }
    
    private func filterImage()
    {
        guard
        
            let cgImage:CGImage = normalizedImage?.cgImage
        
        else
        {
            viewHome.showImage()
            
            return
        }
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
        
        normalize(
            image:image)
        { [weak self] in
            
            self?.scaleImage(onCompletion:
            { [weak self] in
                
                self?.loadTexture(onCompletion:
                { [weak self] in
                    
                    self?.viewHome.showImage()
                })
            })
        }
    }
    
    func updateFilter()
    {
        viewHome.showImage()
    }
    
    func next()
    {
        viewHome.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.filterImage()
        }
    }
}
