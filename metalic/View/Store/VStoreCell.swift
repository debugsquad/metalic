import UIKit

class VStoreCell:UICollectionViewCell
{
    weak var imageView:UIImageView!
    weak var labelTitle:UILabel!
    weak var labelPrice:UILabel!
    weak var labelStatus:UILabel!
    weak var buttonPurchase:UIButton!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:14)
        labelTitle.textColor = UIColor.main
        self.labelTitle = labelTitle
        
        let labelPrice:UILabel = UILabel()
        labelPrice.isUserInteractionEnabled = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.backgroundColor = UIColor.clear
        labelPrice.font = UIFont.medium(size:14)
        labelPrice.textColor = UIColor.black
        self.labelPrice = labelPrice
        
        let labelStatus:UILabel = UILabel()
        labelStatus.isUserInteractionEnabled = false
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.backgroundColor = UIColor.clear
        labelStatus.font = UIFont.medium(size:12)
        labelStatus.textColor = UIColor.black
        self.labelStatus = labelStatus
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(labelPrice)
        addSubview(labelStatus)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
