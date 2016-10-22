import Foundation

class MStorePurchaseItem
{
    private weak var dbFilter:DObjectPurchase!
    
    init(dbFilter:DObjectPurchase)
    {
        self.dbFilter = dbFilter
    }
}
