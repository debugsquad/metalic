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
    private let kBorderHeight:CGFloat = 1
    let kImageMargin:CGFloat = 20
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.white
        
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
        viewCrop.isHidden = true
        self.viewCrop = viewCrop
        
        let menuCrop:VHomeEditCropMenu = VHomeEditCropMenu(controller:controller)
        menuCrop.isHidden = true
        self.menuCrop = menuCrop
        
        addSubview(imageView)
        addSubview(viewCrop)
        addSubview(border)
        addSubview(menu)
        addSubview(menuCrop)
        
        let views:[String:UIView] = [
            "menu":menu,
            "imageView":imageView,
            "viewCrop":viewCrop,
            "menuCrop":menuCrop,
            "border":border]
        
        let metrics:[String:CGFloat] = [
            "menuHeight":kMenuHeight,
            "imageMargin":kImageMargin,
            "statusbarHeight":kStatusbarHeight,
            "borderHeight":kBorderHeight]
        
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
            withVisualFormat:"H:|-0-[border]-0-|",
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
            withVisualFormat:"V:[menu]-0-[border(borderHeight)]",
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
        viewCrop.isHidden = false
    }
    
    func endCropMode()
    {
        menu.isHidden = false
        menuCrop.isHidden = true
        viewCrop.isHidden = true
    }
}
