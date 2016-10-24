import Foundation
import StoreKit

class MStorePurchaseItem
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
            
            let purchaseClass:String = dbFilter.purchaseClass
            
        else
        {
            asset = kEmpty
            title = kEmpty
            
            return
        }
        
        let classType:AnyClass? = NSClassFromString(purchaseClass)
        let filterClass:MFiltersItem.Type = classType as! MFiltersItem.Type
        let filterItem:MFiltersItem = filterClass.init()
        
        title = filterItem.name
        asset = filterItem.asset
    }
}
