import UIKit

class VParent:UIView
{
    weak var parent:CParent!
    weak var bar:VBar!
    weak var layoutBarHeight:NSLayoutConstraint!
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.3
    
    convenience init(parent:CParent)
    {
        self.init()
        self.parent = parent
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let barDelta:CGFloat = kBarHeight - kBarMinHeight
        let bar:VBar = VBar(parent:parent, barHeight:kBarHeight, barDelta:barDelta)
        self.bar = bar
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarHeight = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBarHeight)
        
        addConstraint(layoutBarHeight)
    }
    
    //MARK: private
    
    private func scroll(controller:CController, delta:CGFloat, completion:@escaping(() -> ()))
    {
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:-delta)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-delta)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        parent.controllers.last?.layoutLeft.constant = delta
        parent.controllers.last?.layoutRight.constant = delta
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    //MARK: public
    
    func over(controller:CController, underBar:Bool)
    {
        if underBar
        {
            insertSubview(controller.view, belowSubview:bar)
        }
        else
        {
            addSubview(controller.view)
        }
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
    }
    
    func fromLeft(controller:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        scroll(controller:controller, delta:width, completion:completion)
    }
    
    func fromRight(controller:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = -bounds.maxX
        scroll(controller:controller, delta:width, completion:completion)
    }
    
    func push(controller:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:width)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:width)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        parent.controllers.last?.layoutLeft.constant = -width_2
        parent.controllers.last?.layoutRight.constant = -width_2
        parent.controllers.last?.addShadow()
        bar.push(name:controller.title)
        
        UIView.animate(withDuration:kAnimationDuration, animations:
            {
                self.layoutIfNeeded()
                self.parent.controllers.last?.shadow?.maxAlpha()
            })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func pop(completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        let countControllers:Int = parent.controllers.count
        let lastController:Int = countControllers - 1
        let previousController:Int = countControllers - 2
        let controller:CController = parent.controllers[lastController]
        let previous:CController = parent.controllers[previousController]
        controller.layoutRight.constant = width
        controller.layoutLeft.constant = width
        previous.layoutLeft.constant = 0
        previous.layoutRight.constant = 0
        bar.pop()
        
        UIView.animate(withDuration:kAnimationDuration, animations:
            {
                self.layoutIfNeeded()
                previous.shadow?.minAlpha()
            })
        { (done:Bool) in
            
            previous.shadow?.removeFromSuperview()
            completion()
        }
    }
    
    func dismiss(completion:@escaping(() -> ()))
    {
        let countControllers:Int = parent.controllers.count
        let controller:CController = parent.controllers[countControllers - 1]
        
        UIView.animate(withDuration:kAnimationDuration, animations:
            {
                controller.view.alpha = 0
            })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func scrollDidScroll(scroll:UIScrollView)
    {
        var offsetY:CGFloat = kBarHeight - scroll.contentOffset.y
        
        if offsetY < kBarMinHeight
        {
            offsetY = kBarMinHeight
        }
        
        layoutBarHeight.constant = offsetY
    }
}
