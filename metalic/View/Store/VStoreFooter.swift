import UIKit

class VStoreFooter:UICollectionReusableView
{
    weak var labelError:UILabel!
    private let kButtonHeight:CGFloat = 36
    private let kButtonBottom:CGFloat = 20
    private let kCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let labelError:UILabel = UILabel()
        labelError.isUserInteractionEnabled = false
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.backgroundColor = UIColor.clear
        labelError.font = UIFont.medium(size:14)
        labelError.textColor = UIColor(red:1, green:0.2, blue:0, alpha:1)
        labelError.textAlignment = NSTextAlignment.center
        labelError.numberOfLines = 0
        self.labelError = labelError
        
        let buttonTryAgain:UIButton = UIButton()
        buttonTryAgain.clipsToBounds = true
        buttonTryAgain.translatesAutoresizingMaskIntoConstraints = false
        buttonTryAgain.backgroundColor = UIColor.main
        buttonTryAgain.setTitleColor(UIColor.white, for:UIControlState.normal)
        buttonTryAgain.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        buttonTryAgain.setTitle(
            NSLocalizedString("VStoreFooter_buttonTryAgain", comment:""),
            for:UIControlState.normal)
        buttonTryAgain.titleLabel!.font = UIFont.bold(size:12)
        buttonTryAgain.layer.cornerRadius = kCornerRadius
        buttonTryAgain.addTarget(
            self,
            action:#selector(actionTryAgain(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(labelError)
        addSubview(buttonTryAgain)
        
        let views:[String:UIView] = [
            "labelError":labelError,
            "buttonTryAgain":buttonTryAgain]
        
        let metrics:[String:CGFloat] = [
            "buttonHeight":kButtonHeight,
            "buttonBottom":kButtonBottom]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelError]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[buttonTryAgain]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[labelError]-0-[buttonTryAgain(buttonHeight)]-(buttonBottom)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionTryAgain(sender button:UIButton)
    {
        MStore.sharedInstance.checkAvailability()
    }
    
    //MARK: public
    
    func showError(errorString:String?)
    {
        labelError.text = errorString
    }
}
