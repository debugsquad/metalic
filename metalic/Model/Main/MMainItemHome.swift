import UIKit

class MMainItemHome:MMainItem
{
    private let kIconImage:String = "assetGenericHome"
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:CHome = CHome()
        
        return controller
    }
}
