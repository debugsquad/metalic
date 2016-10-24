import Foundation
import StoreKit

class MStorePurchaseItem:NSObject
{
    private weak var dbFilter:DObjectPurchase!
    let title:String
    var price:String?
    var skProduct:SKProduct?
    var status:MStorePurchaseItemStatus
    var asset:String
    private let kEmpty:String = ""
    
    init(dbFilter:DObjectPurchase)
    {
        self.dbFilter = dbFilter
        status = MStorePurchaseItemStatusNew()
        
        guard
            
            let className:String = dbFilter.purchaseClass,
            let filterItem:MFiltersItem = MFiltersItem.Factory(className:className)
            
        else
        {
            asset = kEmpty
            title = kEmpty
            
            return
        }
        
        title = filterItem.name
        asset = filterItem.asset
    }
    
    //MARK: public
    
    func purchased()
    {
        status = MStorePurchaseItemStatusPurchased()
        dbFilter.purchased = true
        
        DManager.sharedInstance.save()
    }
}
