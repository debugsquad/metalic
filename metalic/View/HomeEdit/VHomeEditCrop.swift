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
        
        let overlayLeft:VHomeEditCropOverlay = VHomeEditCropOverlay()
        let overlayRight:VHomeEditCropOverlay = VHomeEditCropOverlay()
        let overlayTop:VHomeEditCropOverlay = VHomeEditCropOverlay()
        let overlayBottom:VHomeEditCropOverlay = VHomeEditCropOverlay()
        
        addSubview(overlayLeft)
        addSubview(overlayRight)
        addSubview(overlayTop)
        addSubview(overlayBottom)
        
        layoutOverlayLeft = NSLayoutConstraint(
            item:overlayLeft,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:100)
        layoutOverlayTop = NSLayoutConstraint(
            item:overlayTop,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:100)
        layoutOverlayRight = NSLayoutConstraint(
            item:overlayRight,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-100)
        layoutOverlayBottom = NSLayoutConstraint(
            item:overlayBottom,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:-100)
        
        addConstraint(layoutOverlayLeft)
        addConstraint(layoutOverlayTop)
        addConstraint(layoutOverlayRight)
        addConstraint(layoutOverlayBottom)
    }
    
    //MARK: public
    
    func startCropping()
    {
        isHidden = false
    }
}
