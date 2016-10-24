import Foundation

class MStorePurchaseItemStatus
{
    let title:String
    let purchaseButton:Bool
    
    init(title:String, purchaseButton:Bool)
    {
        self.title = title
        self.purchaseButton = purchaseButton
    }
}
