import UIKit
import Metal

class CHome:CController
{
    weak var viewHome:VHome!
    private var mtlDevice:MTLDevice?
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mtlDevice = MTLCreateSystemDefaultDevice()
    }
    
    //MARK: public
    
    func imageSelected(image:UIImage?)
    {
        viewHome.viewPicture.imageView.image = image
    }
}
