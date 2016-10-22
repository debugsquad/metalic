import Foundation

class MStorePurchaseItemStatusDeferred:MStorePurchaseItemStatus
{
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemDeferred_name", comment:"")
        super.init(title:title)
    }
}
