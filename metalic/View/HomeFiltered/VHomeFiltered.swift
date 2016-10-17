import UIKit

class VHomeFiltered:UIView
{
    weak var controller:CHomeFiltered!
    weak var viewPicture:VHomeFilteredPicture!
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
