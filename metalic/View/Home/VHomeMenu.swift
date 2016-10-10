import UIKit

class VHomeMenu:UIView
{
    weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
}
