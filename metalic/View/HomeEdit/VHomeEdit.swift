import UIKit

class VHomeEdit:UIView
{
    weak var controller:CHomeEdit!
    
    convenience init(controller:CHomeEdit)
    {
        self.controller = controller
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.black
    }
}
