import UIKit

class VBarCell:UICollectionViewCell
{
    weak var icon:UIImageView!
    weak var label:UILabel!
    weak var model:MMenuItem!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = UIViewContentMode.center
        self.icon = icon
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        
        addSubview(icon)
        addSubview(label)
        
        let views:[String:UIView] = [
            "icon":icon,
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-29-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-16-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
        {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
        {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            icon.image = UIImage(named:model.iconImageOn)
            label.textColor = UIColor.white
        }
        else
        {
            icon.image = UIImage(named:model.iconImageOff)
            label.textColor = UIColor(white:1, alpha:0.5)
        }
    }
    
    //MARK: public
    
    func config(model:MMenuItem)
    {
        self.model = model
        label.text = model.title
        hover()
    }
}
