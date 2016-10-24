import Foundation

class MStorePurchaseItemStatusPurchased:MStorePurchaseItemStatus
{
    private let kPurchaseButton:Bool = false
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemPurchased_name", comment:"")
        super.init(title:title, purchaseButton:kPurchaseButton)
    }
}
