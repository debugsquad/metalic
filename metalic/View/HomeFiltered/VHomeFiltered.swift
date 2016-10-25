import UIKit

class VHomeFiltered:UIView
{
    weak var controller:CHomeFiltered!
    weak var bar:VHomeFilteredBar!
    weak var buttonExport:UIButton!
    private let kBarWidth:CGFloat = 180
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        let background:UIImageView = UIImageView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.contentMode = UIViewContentMode.scaleAspectFill
        background.image = controller.image
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = controller.image
        
        let bar:VHomeFilteredBar = VHomeFilteredBar(controller:controller)
        self.bar = bar
        
        let buttonExport:UIButton = UIButton()
        buttonExport.translatesAutoresizingMaskIntoConstraints = false
        buttonExport.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonExport.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonExport.imageView!.tintColor = UIColor.black
        buttonExport.imageView!.contentMode = UIViewContentMode.center
        buttonExport.imageView!.clipsToBounds = true
        buttonExport.imageEdgeInsets = UIEdgeInsetsMake(20, 18, 0, 0)
        buttonExport.addTarget(
            self,
            action:#selector(actionExport(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonExport = buttonExport
        
        addSubview(background)
        addSubview(blur)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "blur":blur,
            "background":background]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        let controllerBar:VBar = controller.parentController.viewParent.bar
        controllerBar.addSubview(buttonExport)
        
        let barViews:[String:UIView] = [
            "bar":bar]
        
        let barMetrics:[String:CGFloat] = [
            "barWidth":kBarWidth]
        
        controllerBar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[bar(barWidth)]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
        controllerBar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
    }
    
    deinit
    {
        buttonExport.removeFromSuperview()
    }
}
