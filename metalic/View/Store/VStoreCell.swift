import UIKit

class VStoreCell:UICollectionViewCell
{
    weak var imageView:UIImageView!
    weak var labelTitle:UILabel!
    weak var labelPrice:UILabel!
    weak var labelStatus:UILabel!
    weak var buttonPurchase:UIButton!
    private let kImageWidth:CGFloat = 60
    private let kLabelsWidth:CGFloat = 150
    private let kLabelTitleHeight:CGFloat = 17
    private let kLabelPriceHeight:CGFloat = 16
    private let kLabelStatusHeight:CGFloat = 15
    
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
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "labelTitle":labelTitle,
            "labelPrice":labelPrice,
            "labelStatus":labelStatus]
        
        let metrics:[String:CGFloat] = [
            "imageWidth":kImageWidth,
            "labelsWidth":kLabelsWidth,
            "labelTitleHeight":kLabelTitleHeight,
            "labelPriceHeight":kLabelPriceHeight,
            "labelStatusHeight":kLabelStatusHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelTitle(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelPrice(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelStatus(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView(imageWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelTitle(labelTitleHeight)]-0-[labelPrice(labelPriceHeight)]-0-[labelStatus(labelStatusHeight)]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MStorePurchaseItem)
    {
        labelTitle.text = model.title
        labelPrice.text = model.price
        labelStatus.text = model.status.title
        imageView.image = UIImage(named:model.asset)
    }
}
