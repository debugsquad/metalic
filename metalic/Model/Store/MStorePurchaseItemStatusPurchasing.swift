import Foundation

class MStorePurchaseItemStatusPurchasing:MStorePurchaseItemStatus
{
    private let kPurchaseButton:Bool = false
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemPurchasing_name", comment:"")
        super.init(title:title, purchaseButton:kPurchaseButton)
    }
}
