import UIKit
import Metal

class CHome:CController
{
    weak var viewHome:VHome!
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: public
    
    func imageSelected(image:UIImage?)
    {
        viewHome.viewPicture.imageView.image = image
    }
}
