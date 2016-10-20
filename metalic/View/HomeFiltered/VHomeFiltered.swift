import UIKit

class VHomeFiltered:UIView
{
    weak var controller:CHomeFiltered!
    weak var buttonExport:UIButton!
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = controller.image
        
        let buttonExport:UIButton = UIButton()
        buttonExport.translatesAutoresizingMaskIntoConstraints = false
        buttonExport.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonExport.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonExport.imageView!.tintColor = UIColor.black
        buttonExport.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0)
        self.buttonExport = buttonExport
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
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
        
        let bar:VBar = controller.parentController.viewParent.bar
        bar.addSubview(buttonExport)
        
        let barViews:[String:UIView] = [
            "buttonExport":buttonExport]
        
        let barMetrics:[String:CGFloat] = [:]
        
        bar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonExport(60)]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
        bar.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonExport]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
    }
}
