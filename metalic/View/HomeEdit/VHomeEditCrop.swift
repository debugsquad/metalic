import UIKit

class VHomeEditCrop:UIView
{
    weak var controller:CHomeEdit!
    weak var layoutOverlayLeft:NSLayoutConstraint!
    weak var layoutOverlayTop:NSLayoutConstraint!
    weak var layoutOverlayRight:NSLayoutConstraint!
    weak var layoutOverlayBottom:NSLayoutConstraint!
    weak var handlerTopLeft:VHomeEditCropHandler!
    weak var handlerTopRight:VHomeEditCropHandler!
    weak var handlerBottomLeft:VHomeEditCropHandler!
    weak var handlerBottomRight:VHomeEditCropHandler!
    private let kOverlayAlpha:CGFloat = 0.85
    private let kHandlerSize:CGFloat = 50
    private let handlerSize_2:CGFloat
    
    init(controller:CHomeEdit)
    {
        handlerSize_2 = kHandlerSize / 2.0
        
        super.init(frame:CGRect.zero)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
        
        let overlayLeft:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.left)
        let overlayRight:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.right)
        let overlayTop:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.top)
        let overlayBottom:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.bottom)
        let overlayLeftTop:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.none)
        let overlayRightTop:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.none)
        let overlayLeftBottom:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.none)
        let overlayRightBottom:VHomeEditCropOverlay = VHomeEditCropOverlay(
            borderPosition:VHomeEditCropOverlay.BorderPosition.none)
        
        let handlerTopLeft:VHomeEditCropHandler = VHomeEditCropHandler()
        self.handlerTopLeft = handlerTopLeft
        
        let handlerTopRight:VHomeEditCropHandler = VHomeEditCropHandler()
        self.handlerTopRight = handlerTopRight
        
        let handlerBottomLeft:VHomeEditCropHandler = VHomeEditCropHandler()
        self.handlerBottomLeft = handlerBottomLeft
        
        let handlerBottomRight:VHomeEditCropHandler = VHomeEditCropHandler()
        self.handlerBottomRight = handlerBottomRight
        
        addSubview(overlayLeft)
        addSubview(overlayRight)
        addSubview(overlayTop)
        addSubview(overlayBottom)
        addSubview(overlayLeftTop)
        addSubview(overlayRightTop)
        addSubview(overlayLeftBottom)
        addSubview(overlayRightBottom)
        addSubview(handlerTopLeft)
        addSubview(handlerTopRight)
        addSubview(handlerBottomLeft)
        addSubview(handlerBottomRight)
        
        let views:[String:UIView] = [
            "overlayLeft":overlayLeft,
            "overlayTop":overlayTop,
            "overlayRight":overlayRight,
            "overlayBottom":overlayBottom,
            "overlayLeftTop":overlayLeftTop,
            "overlayRightTop":overlayRightTop,
            "overlayLeftBottom":overlayLeftBottom,
            "overlayRightBottom":overlayRightBottom,
            "handlerTopLeft":handlerTopLeft,
            "handlerTopRight":handlerTopRight,
            "handlerBottomLeft":handlerBottomLeft,
            "handlerBottomRight":handlerBottomRight]
        
        let metrics:[String:CGFloat] = [
            "handlerSize":kHandlerSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayLeft]-0-[overlayTop]-0-[overlayRight]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayLeft]-0-[overlayBottom]-0-[overlayRight]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[overlayLeft]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayRight]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[overlayLeftTop]-0-[overlayTop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayTop]-0-[overlayRightTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[overlayLeftBottom]-0-[overlayBottom]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayBottom]-0-[overlayRightBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerTopLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerTopRight(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerBottomLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerBottomRight(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[overlayTop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayTop]-0-[overlayLeft]-0-[overlayBottom]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayTop]-0-[overlayRight]-0-[overlayBottom]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[overlayLeftTop]-0-[overlayLeft]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[overlayRightTop]-0-[overlayRight]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayLeft]-0-[overlayLeftBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayRight]-0-[overlayRightBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerTopLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerTopRight(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerBottomLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerBottomRight(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutOverlayLeft = NSLayoutConstraint(
            item:overlayLeft,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:100)
        layoutOverlayTop = NSLayoutConstraint(
            item:overlayTop,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:100)
        layoutOverlayRight = NSLayoutConstraint(
            item:overlayRight,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:100)
        layoutOverlayBottom = NSLayoutConstraint(
            item:overlayBottom,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:100)
        
        addConstraint(layoutOverlayLeft)
        addConstraint(layoutOverlayTop)
        addConstraint(layoutOverlayRight)
        addConstraint(layoutOverlayBottom)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func startCropping()
    {
        isHidden = false
    }
}
