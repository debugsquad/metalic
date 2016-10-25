import UIKit

class VHomeEditBar:UIView
{
    weak var controller:CHomeEdit!
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
}
