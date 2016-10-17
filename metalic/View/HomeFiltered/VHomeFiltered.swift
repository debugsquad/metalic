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
        
        let viewPicture:VHomeFilteredPicture = VHomeFilteredPicture(controller:controller)
        self.viewPicture = viewPicture
        
        addSubview(viewPicture)
        
        let views:[String:UIView] = [
            "viewPicture":viewPicture]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewPicture]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewPicture]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
