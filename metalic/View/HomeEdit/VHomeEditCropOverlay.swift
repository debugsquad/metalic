import UIKit

class VHomeEditCropOverlay:UIView
{
    private let kAlpha:CGFloat = 0.85
    
    init()
    {
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0, alpha:kAlpha)
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
