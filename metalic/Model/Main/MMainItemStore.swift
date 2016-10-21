import UIKit

class MMainItemStore:MMainItem
{
    private let kIconImage:String = "assetGenericStore"
    
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
