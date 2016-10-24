import UIKit

class VHomeMenuCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var imageView:UIImageView!
    private let kLabelHeight:CGFloat = 16
    private let kLabelBottom:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:12)
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "label":label,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "labelHeight":kLabelHeight,
            "labelBottom":kLabelBottom]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-[label(labelHeight)]-(labelBottom)-|",
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
            backgroundColor = UIColor.main
            label.textColor = UIColor.white
        }
        else
        {
            backgroundColor = UIColor.clear
            label.textColor = UIColor(white:0.75, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(model:MFiltersItem)
    {
        label.text = model.name
        imageView.image = UIImage(named:model.asset)
        hover()
    }
}
