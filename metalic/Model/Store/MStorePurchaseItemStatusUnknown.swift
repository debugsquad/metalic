import Foundation

class MStorePurchaseItemStatusUnknown:MStorePurchaseItemStatus
{
    private let kPurchaseButton:Bool = false
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemUnknown_name", comment:"")
        super.init(title:title, purchaseButton:kPurchaseButton)
    }
}
