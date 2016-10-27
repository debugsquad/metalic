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
    private let kHandlersMinSeparation:CGFloat = 40
    private let handlerSize_2:CGFloat
    private let imageWidth:CGFloat
    private let imageHeight:CGFloat
    private var marginX:CGFloat
    private var marginY:CGFloat
    private var deltaLeft:CGFloat
    private var deltaTop:CGFloat
    private var deltaRight:CGFloat
    private var deltaBottom:CGFloat
    
    init(controller:CHomeEdit)
    {
        handlerSize_2 = kHandlerSize / 2.0
        let imageSize:CGSize = controller.filtered.image.size
        imageWidth = imageSize.width
        imageHeight = imageSize.height
        marginX = 0
        marginY = 0
        deltaLeft = 0
        deltaRight = 0
        deltaTop = 0
        deltaBottom = 0

        super.init(frame:CGRect.zero)
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
            "handlerSize":kHandlerSize,
            "handlerSize_2":-handlerSize_2]
        
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
            withVisualFormat:"H:[overlayLeft]-(handlerSize_2)-[handlerTopLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerTopRight(handlerSize)]-(handlerSize_2)-[overlayRight]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[overlayLeft]-(handlerSize_2)-[handlerBottomLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[handlerBottomRight(handlerSize)]-(handlerSize_2)-[overlayRight]",
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
            withVisualFormat:"V:[overlayTop]-(handlerSize_2)-[handlerTopLeft(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[overlayTop]-(handlerSize_2)-[handlerTopRight(handlerSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerBottomLeft(handlerSize)]-(handlerSize_2)-[overlayBottom]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[handlerBottomRight(handlerSize)]-(handlerSize_2)-[overlayBottom]",
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
            constant:0)
        layoutOverlayTop = NSLayoutConstraint(
            item:overlayTop,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutOverlayRight = NSLayoutConstraint(
            item:overlayRight,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutOverlayBottom = NSLayoutConstraint(
            item:overlayBottom,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutOverlayLeft)
        addConstraint(layoutOverlayTop)
        addConstraint(layoutOverlayRight)
        addConstraint(layoutOverlayBottom)
        
        let panTopLeft:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(panGesturized(sender:)))
        let panTopRight:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(panGesturized(sender:)))
        let panBottomLeft:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(panGesturized(sender:)))
        let panBottomRight:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(panGesturized(sender:)))
    
        handlerTopLeft.panGestureRecognizer = panTopLeft
        handlerTopRight.panGestureRecognizer = panTopRight
        handlerBottomLeft.panGestureRecognizer = panBottomLeft
        handlerBottomRight.panGestureRecognizer = panBottomRight
        handlerTopLeft.addGestureRecognizer(panTopLeft)
        handlerTopRight.addGestureRecognizer(panTopRight)
        handlerBottomLeft.addGestureRecognizer(panBottomLeft)
        handlerBottomRight.addGestureRecognizer(panBottomRight)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let imageMargin:CGFloat = controller.viewEdit.kImageMargin
        let maxWidth:CGFloat = bounds.maxX - imageMargin
        let maxHeight:CGFloat = bounds.maxY - imageMargin
        let deltaX:CGFloat = imageWidth / maxWidth
        let deltaY:CGFloat = imageHeight / maxHeight
        let maxDelta:CGFloat = max(deltaX, deltaY)
        let scaledWidth:CGFloat = imageWidth / maxDelta
        let scaledHeight:CGFloat = imageHeight / maxDelta
        let remainWidth:CGFloat = maxWidth - scaledWidth
        let remainHeight:CGFloat = maxHeight - scaledHeight
        let marginHorizontal:CGFloat = remainWidth / 2.0
        let marginVertical:CGFloat = remainHeight / 2.0
        marginX = marginHorizontal + imageMargin
        marginY = marginVertical + imageMargin
        
        layoutOverlayLeft.constant = marginX + deltaLeft
        layoutOverlayRight.constant = marginX + deltaRight
        layoutOverlayBottom.constant = marginY + deltaBottom
        layoutOverlayTop.constant = marginY + deltaTop
        
        super.layoutSubviews()
    }
    
    //MARK: pan gesture
    
    func panGesturized(sender gesture:UIPanGestureRecognizer)
    {
        let handler:VHomeEditCropHandler
        let layoutLeft:NSLayoutConstraint?
        let layoutTop:NSLayoutConstraint?
        let layoutRight:NSLayoutConstraint?
        let layoutBottom:NSLayoutConstraint?
        
        if gesture === handlerTopLeft.panGestureRecognizer
        {
            handler = handlerTopLeft
            
            layoutTop = layoutOverlayTop
            layoutLeft = layoutOverlayLeft
            layoutBottom = nil
            layoutRight = nil
        }
        else if gesture === handlerTopRight.panGestureRecognizer
        {
            handler = handlerTopRight
            
            layoutTop = layoutOverlayTop
            layoutLeft = nil
            layoutBottom = nil
            layoutRight = layoutOverlayRight
        }
        else if gesture === handlerBottomLeft.panGestureRecognizer
        {
            handler = handlerBottomLeft
            
            layoutTop = nil
            layoutLeft = layoutOverlayLeft
            layoutBottom = layoutOverlayBottom
            layoutRight = nil
        }
        else
        {
            handler = handlerBottomRight
            
            layoutTop = nil
            layoutLeft = nil
            layoutBottom = layoutOverlayBottom
            layoutRight = layoutOverlayRight
        }
        
        switch gesture.state
        {
            case UIGestureRecognizerState.began:
            
                if layoutLeft != nil
                {
                    handler.initialX = layoutLeft!.constant
                }
                else if layoutRight != nil
                {
                    handler.initialX = layoutRight!.constant
                }
                
                if layoutTop != nil
                {
                    handler.initialY = layoutTop!.constant
                }
                else
                {
                    handler.initialY = layoutBottom!.constant
                }
                
                handler.setSelected()
                
                break
            
            case UIGestureRecognizerState.changed:
            
                let screenWidth:CGFloat = bounds.maxX
                let screenHeight:CGFloat = bounds.maxY
                let translation:CGPoint = gesture.translation(in:self)
                let translationX:CGFloat = translation.x
                let translationY:CGFloat = translation.y
                
                if layoutLeft != nil
                {
                    let maxX:CGFloat = screenWidth - layoutOverlayRight.constant - kHandlersMinSeparation
                    var newX:CGFloat = handler.initialX + translationX
                    
                    if newX > maxX
                    {
                        newX = maxX
                    }
                    
                    if newX < 0
                    {
                        newX = 0
                    }
                    
                    deltaLeft = newX - marginX
                }
                else if layoutRight != nil
                {
                    let maxX:CGFloat = screenWidth - layoutOverlayLeft.constant - kHandlersMinSeparation
                    var newX:CGFloat = handler.initialX - translationX
                    
                    if newX > maxX
                    {
                        newX = maxX
                    }
                    
                    if newX < 0
                    {
                        newX = 0
                    }
                    
                    deltaRight = newX - marginX
                }
                
                if layoutTop != nil
                {
                    let maxY:CGFloat = screenHeight - layoutOverlayBottom.constant - kHandlersMinSeparation
                    var newY:CGFloat = handler.initialY + translationY
                    
                    if newY > maxY
                    {
                        newY = maxY
                    }
                    
                    if newY < 0
                    {
                        newY = 0
                    }
                    
                    deltaTop = newY - marginY
                }
                else
                {
                    let maxY:CGFloat = screenHeight - layoutOverlayTop.constant - kHandlersMinSeparation
                    var newY:CGFloat = handler.initialY - translationY
                    
                    if newY > maxY
                    {
                        newY = maxY
                    }
                    
                    if newY < marginY
                    {
                        newY = marginY
                    }
                    
                    deltaBottom = newY - marginY
                }
                
                break
            
            default:
            
                handler.setStandby()
                
                break
        }
        
        setNeedsUpdateConstraints()
    }
    
    //MARK: public
    
    func willChangeSize()
    {
        layoutOverlayLeft.constant = 0
        layoutOverlayRight.constant = 0
        layoutOverlayBottom.constant = 0
        layoutOverlayTop.constant = 0
    }
}
