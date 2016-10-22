import Foundation

class MStorePurchaseItemStatusPurchasing:MStorePurchaseItemStatus
{
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemPurchasing_name", comment:"")
        super.init(title:title)
    }
}
