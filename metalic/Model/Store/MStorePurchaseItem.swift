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
    
    init(dbFilter:DObjectPurchase)
    {
        self.dbFilter = dbFilter
        
        let titleLocalized:String = String(
            format:"%@_name",
            dbFilter.purchaseId!)
        title = NSLocalizedString(titleLocalized, comment:"")
        status = MStorePurchaseItemStatusNew()
        
        guard
            
            let purchaseClass:String = dbFilter.purchaseClass
        
        else
        {
            asset = ""
            
            return
        }
        
        let classType:AnyClass? = NSClassFromString(purchaseClass)
        let filterClass:MFiltersItem.Type = classType as! MFiltersItem.Type
        let filterItem:MFiltersItem = filterClass.init()
        
        asset = filterItem.asset
    }
}
