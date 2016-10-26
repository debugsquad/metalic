import UIKit

class VHomeEditCrop:UIView
{
    weak var controller:CHomeEdit!
    weak var overlayView:UIView!
    weak var maskingView:UIView!
    weak var layoutMaskingLeft:NSLayoutConstraint!
    weak var layoutMaskingTop:NSLayoutConstraint!
    weak var layoutMaskingRight:NSLayoutConstraint!
    weak var layoutMaskingBottom:NSLayoutConstraint!
    private let kOverlayAlpha:CGFloat = 0.6
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
        
        let overlayView:UIView = UIView()
        overlayView.isUserInteractionEnabled = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor(white:0, alpha:kOverlayAlpha)
        overlayView.clipsToBounds = true
        self.overlayView = overlayView
        
        let maskingView:UIView = UIView()
        maskingView.isUserInteractionEnabled = false
        maskingView.translatesAutoresizingMaskIntoConstraints = false
        maskingView.backgroundColor = UIColor.red
        maskingView.clipsToBounds = true
        self.maskingView = maskingView
        
        addSubview(overlayView)
        addSubview(maskingView)
        
        let views:[String:UIView] = [
            "overlayView":overlayView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[overlayView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[overlayView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutMaskingLeft = NSLayoutConstraint(
            item:maskingView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:100)
        layoutMaskingTop = NSLayoutConstraint(
            item:maskingView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:100)
        layoutMaskingRight = NSLayoutConstraint(
            item:maskingView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-100)
        layoutMaskingBottom = NSLayoutConstraint(
            item:maskingView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:-100)
        
        addConstraint(layoutMaskingLeft)
        addConstraint(layoutMaskingTop)
        addConstraint(layoutMaskingRight)
        addConstraint(layoutMaskingBottom)
    }
    
    //MARK: public
    
    func startCropping()
    {
        isHidden = false
    }
}
