import UIKit

class VHome:UIView
{
    weak var controller:CHome!
    weak var viewPicture:VHomePicture!
    weak var viewSelector:VHomeSelector!
    weak var viewMenu:VHomeMenu!
    private let kSelectorHeight:CGFloat = 45
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
        
        let viewSelector:VHomeSelector = VHomeSelector(controller:controller)
        self.viewSelector = viewSelector
        
        let viewMenu:VHomeMenu = VHomeMenu(controller:controller)
        self.viewMenu = viewMenu
        
        addSubview(viewPicture)
        addSubview(viewSelector)
        addSubview(viewMenu)
        
        let views:[String:UIView] = [
            "viewPicture":viewPicture,
            "viewSelector":viewSelector,
            "viewMenu":viewMenu]
        
        let metrics:[String:CGFloat] = [
            "selectorHeight":kSelectorHeight,
            "menuHeight":kMenuHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewPicture]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewSelector]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewMenu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewPicture]-0-[viewSelector(selectorHeight)]-0-[viewMenu(menuHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
