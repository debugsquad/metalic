import UIKit

class VHomeEditCropMenu:UIView
{
    weak var controller:CHomeEdit!
    weak var layoutButtonsLeft:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 120
    private let buttonsWidth:CGFloat
    
    init(controller:CHomeEdit)
    {
        buttonsWidth = kButtonWidth + kButtonWidth
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle(
            NSLocalizedString("VHomeEditCropMenu_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.bold(
            size:14)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonCrop:UIButton = UIButton()
        buttonCrop.translatesAutoresizingMaskIntoConstraints = false
        buttonCrop.setTitle(
            NSLocalizedString("VHomeEditCropMenu_buttonCrop", comment:""),
            for:UIControlState.normal)
        buttonCrop.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCrop.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCrop.titleLabel!.font = UIFont.bold(
            size:14)
        buttonCrop.addTarget(
            self,
            action:#selector(actionCrop(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCancel)
        addSubview(buttonCrop)
        
        let views:[String:UIView] = [
            "buttonCancel":buttonCancel,
            "buttonCrop":buttonCrop]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCancel]-0-[buttonCrop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonCancel]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonCrop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonsLeft = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonsLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let remain:CGFloat = totalWidth - buttonsWidth
        let margin:CGFloat = remain / 2.0
        layoutButtonsLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        
    }
    
    func actionCrop(sender button:UIButton)
    {
        
    }
}
