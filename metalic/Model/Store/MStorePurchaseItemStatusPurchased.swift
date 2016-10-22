import Foundation

class MStorePurchaseItemStatusPurchased:MStorePurchaseItemStatus
{
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemPurchased_name", comment:"")
        super.init(title:title)
    }
}
