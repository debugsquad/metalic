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
        
        print(dbFilter.purchaseClass)
        
        guard
            
            let purchaseClass:String = dbFilter.purchaseClass,
            let classType:AnyObject.Type = NSClassFromString(purchaseClass),
            let filterClass:MFiltersItem.Type = classType as? MFiltersItem.Type
            
        else
        {
            asset = kEmpty
            title = kEmpty
            
            return
        }
        
        let filterItem:MFiltersItem = filterClass.init()
        
        title = filterItem.name
        asset = filterItem.asset
    }
}
