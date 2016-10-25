import UIKit

class VHomeFilteredBar:UIView
{
    weak var controller:CHomeFiltered!
    private let kButtonWidth:CGFloat = 45
    
    convenience init(controller:CHomeFiltered)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
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
        buttonExport.imageEdgeInsets = UIEdgeInsetsMake(20, 3, 0, 0)
        buttonExport.addTarget(
            self,
            action:#selector(actionExport(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonEdit:UIButton = UIButton()
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        buttonEdit.setImage(
            #imageLiteral(resourceName: "assetGenericEdit").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonEdit.setImage(
            #imageLiteral(resourceName: "assetGenericEdit").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonEdit.imageView!.tintColor = UIColor.black
        buttonEdit.imageView!.contentMode = UIViewContentMode.center
        buttonEdit.imageView!.clipsToBounds = true
        buttonEdit.imageEdgeInsets = UIEdgeInsetsMake(20, 3, 0, 0)
        buttonEdit.addTarget(
            self,
            action:#selector(actionEdit(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonExport)
        addSubview(buttonEdit)
        
        let barViews:[String:UIView] = [
            "buttonExport":buttonExport,
            "buttonEdit":buttonEdit]
        
        let barMetrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonEdit(buttonWidth)]-0-[buttonExport(buttonWidth)]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonExport]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonEdit]-0-|",
            options:[],
            metrics:barMetrics,
            views:barViews))
    }
    
    //MARK: actions
    
    func actionExport(sender button:UIButton)
    {
        controller.export()
    }
    
    func actionEdit(sender button:UIButton)
    {
        let controllerEdit:CHomeEdit = CHomeEdit(filtered:controller)
        controller.parentController.push(controller:controllerEdit)
    }
}
