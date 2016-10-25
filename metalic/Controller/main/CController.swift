import UIKit

class CController:UIViewController
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var shadow:VShadow?
    
    open var name:NSString
    {
        get
        {
            let classType:AnyClass = object_getClass(self)
            
            return NSStringFromClass(classType) as NSString
        }
    }
    
    override var title:String?
    {
        didSet
        {
            parentController.viewParent.bar.label.text = title
        }
    }
    
    var parentController:CParent
    {
        get
        {
            return self.parent as! CParent
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        FMain.sharedInstance.analytics.screen(controller:self)
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return false
    }
    
    //MARK: public
    
    func addShadow()
    {
        let shadow:VShadow = VShadow()
        self.shadow = shadow
        
        view.addSubview(shadow)
        
        let views:[String:UIView] = [
            "shadow":shadow]
        
        let metrics:[String:CGFloat] = [:]
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        view.layoutIfNeeded()
    }
}
