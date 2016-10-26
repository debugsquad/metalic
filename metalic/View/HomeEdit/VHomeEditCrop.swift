import UIKit

class VHomeEditCrop:UIView
{
    weak var controller:CHomeEdit!
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
    }
}
