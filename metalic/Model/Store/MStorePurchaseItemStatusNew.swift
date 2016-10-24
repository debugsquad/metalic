import Foundation

class MStorePurchaseItemStatusNew:MStorePurchaseItemStatus
{
    private let kPurchaseButton:Bool = true
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseItemNew_name", comment:"")
        super.init(title:title, purchaseButton:kPurchaseButton)
    }
}
