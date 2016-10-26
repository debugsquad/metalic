import UIKit

class VHomeEditCropHandler:UIView
{
    weak var layoutHorizontal:NSLayoutConstraint!
    weak var layoutVertical:NSLayoutConstraint!
    weak var panGestureRecognizer:UIPanGestureRecognizer!
    weak var imageView:UIImageView!
    
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
        self.imageView = imageView
        
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
        imageView.image = #imageLiteral(resourceName: "assetEditCropHandlerOn")
    }
    
    func setStandby()
    {
        imageView.image = #imageLiteral(resourceName: "assetEditCropHandlerOff")
    }
}
