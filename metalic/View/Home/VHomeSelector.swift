import UIKit

class VHomeSelector:UIView
{
    weak var controller:CHome!
    weak var layoutButtonsLeft:NSLayoutConstraint!
    weak var layoutButtonCameraTop:NSLayoutConstraint!
    weak var layoutButtonLibraryTop:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 80
    private let kButtonHeight:CGFloat = 40
    
    convenience init(controller:CHome)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCamera:UIButton = UIButton()
        buttonCamera.translatesAutoresizingMaskIntoConstraints = false
        buttonCamera.clipsToBounds = true
        buttonCamera.setTitle("Camera", for:UIControlState.normal)
        
        let buttonLibrary:UIButton = UIButton()
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.clipsToBounds = true
        buttonLibrary.setTitle("Library", for:UIControlState.normal)
        
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
}
