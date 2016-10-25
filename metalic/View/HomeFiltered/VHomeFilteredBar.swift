import UIKit

class VHomeFilteredBar:UIView
{
    weak var controller:CHomeFiltered!
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
}
