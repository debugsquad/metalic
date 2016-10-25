import UIKit

class VHomeEdit:UIView
{
    weak var controller:CHomeEdit!
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
    }
}
