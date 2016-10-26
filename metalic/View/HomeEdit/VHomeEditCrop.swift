import UIKit

class VHomeEditCrop:UIView
{
    weak var controller:CHomeEdit!
    weak var layoutOverlayLeft:NSLayoutConstraint!
    weak var layoutOverlayTop:NSLayoutConstraint!
    weak var layoutOverlayRight:NSLayoutConstraint!
    weak var layoutOverlayBottom:NSLayoutConstraint!
    private let kOverlayAlpha:CGFloat = 0.85
    
    convenience init(controller:CHomeEdit)
    {
        self.init()
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
        
        let overlayLeft:UIView = UIView()
        overlayLeft.isUserInteractionEnabled = false
        overlayLeft.translatesAutoresizingMaskIntoConstraints = false
        overlayLeft.backgroundColor = UIColor(white:0, alpha:kOverlayAlpha)
        overlayLeft.clipsToBounds = true
        
        let overlayRight:UIView = UIView()
        overlayRight.isUserInteractionEnabled = false
        overlayRight.translatesAutoresizingMaskIntoConstraints = false
        overlayRight.backgroundColor = UIColor(white:0, alpha:kOverlayAlpha)
        overlayRight.clipsToBounds = true
        
        let overlayRight:UIView = UIView()
        overlayRight.isUserInteractionEnabled = false
        overlayRight.translatesAutoresizingMaskIntoConstraints = false
        overlayRight.backgroundColor = UIColor(white:0, alpha:kOverlayAlpha)
        overlayRight.clipsToBounds = true
        
        let overlayLeft:UIView = UIView()
        overlayLeft.isUserInteractionEnabled = false
        overlayLeft.translatesAutoresizingMaskIntoConstraints = false
        overlayLeft.backgroundColor = UIColor(white:0, alpha:kOverlayAlpha)
        overlayLeft.clipsToBounds = true
        
        addSubview(overlayLeft)
        
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
