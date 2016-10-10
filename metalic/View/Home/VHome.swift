import UIKit

class VHome:UIView
{
    weak var controller:CHome!
    weak var viewPicture:VHomePicture!
    weak var viewMenu:VHomeMenu!
    private let kSelectorHeight:CGFloat = 60
    private let kMenuHeight:CGFloat = 100
    
    convenience init(controller:CHome)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        let viewPicture:VHomePicture = VHomePicture(controller:controller)
        self.viewPicture = viewPicture
        
        let viewMenu:VHomeMenu = VHomeMenu(controller:controller)
        self.viewMenu = viewMenu
        
        addSubview(viewPicture)
        addSubview(viewMenu)
        
        let views:[String:UIView] = [
            "viewPicture":viewPicture,
            "viewMenu":viewMenu]
        
        let metrics:[String:CGFloat] = [
            "menuHeight":kMenuHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewPicture]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewMenu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewPicture]-0-[viewMenu(menuHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
