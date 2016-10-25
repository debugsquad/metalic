import UIKit

class VHomeEdit:UIView
{
    weak var controller:CHomeEdit!
    weak var menu:VHomeEditMenu!
    weak var imageView:UIImageView!
    private let kMenuHeight:CGFloat = 80
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
        
        let menu:VHomeEditMenu = VHomeEditMenu(controller:controller)
        self.menu = menu
        
        let imageView:UIImageView = UIImageView()
        self.imageView = imageView
        
        addSubview(menu)
        
        let views:[String:UIView] = [
            "menu":menu]
        
        let metrics:[String:CGFloat] = [
            "menuHeight":kMenuHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[menu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[menu(menuHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
}
