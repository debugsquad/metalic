import UIKit

class VStoreCell:UICollectionViewCell
{
    weak var labelTitle:UILabel!
    weak var labelPrice:UILabel!
    weak var labelStatus:UILabel!
    weak var buttonPurchase:UIButton!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
