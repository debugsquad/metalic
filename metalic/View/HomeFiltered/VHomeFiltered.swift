import UIKit

class VHomeFiltered:UIView
{
    weak var controller:CHomeFiltered!
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
