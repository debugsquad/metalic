import UIKit

class VHomeEditCropMenu:UIView
{
    weak var controller:CHomeEdit!
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
