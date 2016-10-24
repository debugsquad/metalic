import UIKit

class VStoreCell:UICollectionViewCell
{
    weak var imageView:UIImageView!
    weak var labelTitle:UILabel!
    weak var labelPrice:UILabel!
    weak var labelStatus:UILabel!
    weak var buttonPurchase:UIButton!
    private let kImageWidth:CGFloat = 50
    private let kLabelsWidth:CGFloat = 150
    private let kLabelTitleHeight:CGFloat = 17
    private let kLabelPriceHeight:CGFloat = 16
    private let kLabelStatusHeight:CGFloat = 15
    private let kButtonWidth:CGFloat = 110
    private let kButtonHeight:CGFloat = 34
    private let kCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let buttonPurchase:UIButton = UIButton()
        buttonPurchase.translatesAutoresizingMaskIntoConstraints = false
        buttonPurchase.backgroundColor = UIColor.main
        buttonPurchase.clipsToBounds = true
        buttonPurchase.layer.cornerRadius = kCornerRadius
        buttonPurchase.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonPurchase.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonPurchase.setTitle(
            NSLocalizedString("VStoreCell_button", comment:""),
            for:UIControlState.normal)
        buttonPurchase.titleLabel!.font = UIFont.bold(size:14)
        self.buttonPurchase = buttonPurchase
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
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
        labelPrice.font = UIFont.medium(size:12)
        labelPrice.textColor = UIColor.black
        self.labelPrice = labelPrice
        
        let labelStatus:UILabel = UILabel()
        labelStatus.isUserInteractionEnabled = false
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.backgroundColor = UIColor.clear
        labelStatus.font = UIFont.medium(size:12)
        labelStatus.textColor = UIColor.main
        self.labelStatus = labelStatus
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(labelPrice)
        addSubview(labelStatus)
        addSubview(buttonPurchase)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "labelTitle":labelTitle,
            "labelPrice":labelPrice,
            "labelStatus":labelStatus,
            "buttonPurchase":buttonPurchase]
        
        let metrics:[String:CGFloat] = [
            "imageWidth":kImageWidth,
            "labelsWidth":kLabelsWidth,
            "labelTitleHeight":kLabelTitleHeight,
            "labelPriceHeight":kLabelPriceHeight,
            "labelStatusHeight":kLabelStatusHeight,
            "buttonWidth":kButtonWidth,
            "buttonHeight":kButtonHeight]
        
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
            withVisualFormat:"H:[buttonPurchase(buttonWidth)]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelTitle(labelTitleHeight)]-0-[labelStatus(labelStatusHeight)]-0-[labelPrice(labelPriceHeight)]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[buttonPurchase(buttonHeight)]",
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
