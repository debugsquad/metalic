import UIKit

class CStore:CController
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
}
