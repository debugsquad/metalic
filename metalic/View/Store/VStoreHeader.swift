import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let kButtonMarginVr:CGFloat = 20
    private let kButtonMarginHr:CGFloat = 10
    private let kCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonRestore:UIButton = UIButton()
        buttonRestore.clipsToBounds = true
        buttonRestore.translatesAutoresizingMaskIntoConstraints = false
        buttonRestore.backgroundColor = UIColor.main
        buttonRestore.setTitleColor(UIColor.white, for:UIControlState.normal)
        buttonRestore.setTitleColor(UIColor.black, for:UIControlState.highlighted)
        buttonRestore.setTitle(
            NSLocalizedString("VStoreHeader_buttonRestore", comment:""),
            for:UIControlState.normal)
        buttonRestore.layer.cornerRadius = kCornerRadius
        buttonRestore.addTarget(
            self,
            action:#selector(actionRestore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonRestore)
        
        let views:[String:UIView] = [
            "buttonRestore":buttonRestore]
        
        let metrics:[String:CGFloat] = [
            "buttonMarginHr":kButtonMarginHr,
            "buttonMarginVr":kButtonMarginVr]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(buttonMarginHr)-[buttonRestore]-(buttonMarginHr)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(buttonMarginVr)-[buttonRestore]-(buttonMarginVr)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionRestore(sender button:UIButton)
    {
        
    }
}
