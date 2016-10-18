import UIKit
import MetalKit

class CHome:CController
{
    weak var viewHome:VHome!
    var normalizedImage:UIImage?
    var device:MTLDevice!
    var commandQueue:MTLCommandQueue!
    var sourceTexture:MTLTexture?
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
        viewHome.viewPicture.device = device
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
    
    private func textureWith(cgImage:CGImage) -> MTLTexture?
    {
        let mtlTexture:MTLTexture?
        let mtkTextureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        let options:[String:NSObject] = [
            MTKTextureLoaderOptionTextureUsage:MTLTextureUsage.shaderRead.rawValue as NSObject,
            MTKTextureLoaderOptionSRGB:true as NSObject
        ]
        
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
            
            let cgImage:CGImage = normalizedImage?.cgImage
            
        else
        {
            return
        }
        
        sourceTexture = textureWith(cgImage:cgImage)
        onCompletion?()
    }
    
    private func filterImage()
    {
        guard
            
            let resultImage:UIImage = viewHome.viewPicture.presentingTexture?.exportImage()
            
        else
        {
            viewHome.showImage()
            
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            let filteredController:CHomeFiltered = CHomeFiltered(image:resultImage)
            
            self?.parentController.push(controller:filteredController)
            self?.viewHome.showImage()
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
            
            self?.loadTexture(onCompletion:
            { [weak self] in
                
                self?.viewHome.showImage()
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
