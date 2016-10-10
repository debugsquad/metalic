import UIKit

extension UICollectionReusableView
{
    class func reusableIdentifier() -> String
    {
        let classType:AnyClass = object_getClass(self)
        
        return NSStringFromClass(classType)
    }
}
