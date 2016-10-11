import UIKit
import QuartzCore

class VHomePicture:UIView
{
    weak var controller:CHome!
    weak var imageView:UIImageView!
    var metalLayer:CAMetalLayer!
    private let kMinLayerSize:CGFloat = 1
    
    let vertexData:[Float] = [
        0.0, 1.0, 0.0,
        -1.0, -1.0, 0.0,
        1.0, -1.0, 0.0]
    
    var vertexBuffer: MTLBuffer! = nil
    
    convenience init(controller:CHome)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0.985, alpha:1)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews() {
        metalLayer.frame = layer.frame
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func viewLoaded()
    {
        metalLayer = CAMetalLayer()
        metalLayer.device = controller.mtlDevice
        metalLayer.pixelFormat = MTLPixelFormat.bgra8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = CGRect(x:0, y:0, width:kMinLayerSize, height:kMinLayerSize)
        
        layer.addSublayer(metalLayer)
        
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        vertexBuffer = controller.mtlDevice.makeBuffer(bytes:vertexData, length:dataSize, options: MTLResourceOptions.cpuCacheModeWriteCombined)
    }
}
