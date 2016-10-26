import UIKit

class VHomeEdit:UIView
{
    weak var controller:CHomeEdit!
    weak var menu:VHomeEditMenu!
    weak var imageView:UIImageView!
    weak var viewCrop:VHomeEditCrop!
    weak var menuCrop:VHomeEditCropMenu!
    private let kMenuHeight:CGFloat = 50
    private let kStatusbarHeight:CGFloat = 15
    let kImageMargin:CGFloat = 20
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
        
        let menu:VHomeEditMenu = VHomeEditMenu(controller:controller)
        self.menu = menu
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = controller.filtered.image
        self.imageView = imageView
        
        let viewCrop:VHomeEditCrop = VHomeEditCrop(controller:controller)
        self.viewCrop = viewCrop
        
        let menuCrop:VHomeEditCropMenu = VHomeEditCropMenu(controller:controller)
        menuCrop.isHidden = true
        self.menuCrop = menuCrop
        
        addSubview(imageView)
        addSubview(viewCrop)
        addSubview(menu)
        addSubview(menuCrop)
        
        let views:[String:UIView] = [
            "menu":menu,
            "imageView":imageView,
            "viewCrop":viewCrop,
            "menuCrop":menuCrop]
        
        let metrics:[String:CGFloat] = [
            "menuHeight":kMenuHeight,
            "imageMargin":kImageMargin,
            "statusbarHeight":kStatusbarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[menu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[menuCrop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewCrop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(imageMargin)-[imageView]-(imageMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(statusbarHeight)-[menu(menuHeight)]-(imageMargin)-[imageView]-(imageMargin)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(statusbarHeight)-[menuCrop(menuHeight)]-0-[viewCrop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: public
    
    func cropMode()
    {
        menu.isHidden = true
        menuCrop.isHidden = false
        viewCrop.startCropping()
    }
}
