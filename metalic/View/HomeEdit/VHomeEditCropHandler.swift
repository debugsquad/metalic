import UIKit

class VHomeEditCropHandler:UIView
{
    weak var layoutHorizontal:NSLayoutConstraint!
    weak var layoutVertical:NSLayoutConstraint!
    weak var panGestureRecognizer:UIPanGestureRecognizer!
    private let kAlphaStand:CGFloat = 0.5
    private let kAlphaSelected:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "assetEditCropHandler")
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        setStandby()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func setSelected()
    {
        alpha = kAlphaSelected
    }
    
    func setStandby()
    {
        alpha = kAlphaStand
    }
}
