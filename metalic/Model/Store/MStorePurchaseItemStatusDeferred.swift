import Foundation

class MStorePurchaseItemStatusDeferred:MStorePurchaseItemStatus
{
    private let kPurchaseButton:Bool = false
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemDeferred_name", comment:"")
        super.init(title:title, purchaseButton:kPurchaseButton)
    }
}
