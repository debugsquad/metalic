import Foundation
import StoreKit

class MStorePurchaseItem
{
    private weak var dbFilter:DObjectPurchase!
    let title:String
    var skProduct:SKProduct?
    var status:MStorePurchaseItemStatus
    
    init(dbFilter:DObjectPurchase)
    {
        self.dbFilter = dbFilter
        
        let titleLocalized:String = String(
            format:"%@_name",
            dbFilter.purchaseId!)
        title = NSLocalizedString(titleLocalized, comment:"")
        status = MStorePurchaseItemStatusNew()
    }
}
