import UIKit

class VHomeSelector:UIView
{
    weak var controller:CHome!
    weak var layoutButtonsLeft:NSLayoutConstraint!
    weak var layoutButtonCameraTop:NSLayoutConstraint!
    weak var layoutButtonLibraryTop:NSLayoutConstraint!
    private let totalButtonsWidth:CGFloat
    private let kButtonWidth:CGFloat = 80
    private let kButtonHeight:CGFloat = 36
    
    init(controller:CHome)
    {
        totalButtonsWidth = kButtonWidth + kButtonWidth
        
        super.init(frame:CGRect.zero)
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCamera:UIButton = UIButton()
        buttonCamera.translatesAutoresizingMaskIntoConstraints = false
        buttonCamera.clipsToBounds = true
        buttonCamera.setTitle("Camera", for:UIControlState.normal)
        buttonCamera.addTarget(
            self,
            action:#selector(self.actionCamera(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonLibrary:UIButton = UIButton()
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.clipsToBounds = true
        buttonLibrary.setTitle("Library", for:UIControlState.normal)
        buttonLibrary.addTarget(
            self,
            action:#selector(self.actionLibrary(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCamera)
        addSubview(buttonLibrary)
        
        let views:[String:UIView] = [
            "buttonCamera":buttonCamera,
            "buttonLibrary":buttonLibrary]
        
        let metrics:[String:CGFloat] = [
            "buttonWidth":kButtonWidth,
            "buttonHeight":kButtonHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCamera(buttonWidth)]-0-[buttonLibrary(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonCamera(buttonHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonLibrary(buttonHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonsLeft = NSLayoutConstraint(
            item:buttonCamera,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        layoutButtonCameraTop = NSLayoutConstraint(
            item:buttonCamera,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutButtonLibraryTop = NSLayoutConstraint(
            item:buttonLibrary,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonsLeft)
        addConstraint(layoutButtonCameraTop)
        addConstraint(layoutButtonLibraryTop)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainWidth:CGFloat = width - totalButtonsWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        let remainHeight:CGFloat = height - kButtonHeight
        let marginTop:CGFloat = remainHeight / 2.0
        
        layoutButtonsLeft.constant = marginLeft
        layoutButtonCameraTop.constant = marginTop
        layoutButtonLibraryTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCamera(sender button:UIButton)
    {
        let picker:CHomePickerCamera = CHomePickerCamera(controller:controller)
        controller.parentController.present(
            picker,
            animated:true,
            completion:nil)
    }
    
    func actionLibrary(sender button:UIButton)
    {
        let picker:CHomePickerLibrary = CHomePickerLibrary(controller:controller)
        controller.parentController.present(
            picker,
            animated:true,
            completion:nil)
    }
}
