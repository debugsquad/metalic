import UIKit

extension UIColor
{
    open class var main:UIColor
    {
        get
        {
            return UIColor(red:0.3, green:0.5, blue:0.7, alpha:1)
        }
    }
    
    open class var complement:UIColor
    {
        get
        {
            return UIColor(red:0.7, green:0.8, blue:0.1, alpha:1)
        }
    }
    
    open class var background:UIColor
    {
        get
        {
            return UIColor(white:0.97, alpha:1)
        }
    }
}
