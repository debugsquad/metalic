import Foundation
import StoreKit

class MStorePurchase
{
    var mapItems:[String:MStorePurchaseItem]
    private let priceFormatter:NumberFormatter
    
    init()
    {
        mapItems = [:]
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.loadFromDb()
        }
    }
    
    //MARK: private
    
    private func loadFromDb()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectPurchase.self)
        { (objects) in
            
            for object:DObjectPurchase in objects
            {
                let purchaseId:String = object.purchaseId!
                let purchaseItem:MStorePurchaseItem = MStorePurchaseItem(dbFilter:object)
                self.mapItems[purchaseId] = purchaseItem
            }
            
            NotificationCenter.default.post(
                name:Notification.purchasesLoaded,
                object:nil)
        }
    }
    
    //MARK: public
    
    func makeSet() -> Set<String>
    {
        var itemsSet:Set<String> = Set<String>()
        let mapItemsKeys:[String] = Array(mapItems.keys)
        
        for mappedItemKey:String in mapItemsKeys
        {
            itemsSet.insert(mappedItemKey)
        }
        
        return itemsSet
    }
    
    func loadSkProduct(skProduct:SKProduct)
    {
        let productId:String = skProduct.productIdentifier
        
        guard
            
            let mappedItem:MStorePurchaseItem = mapItems[productId]
        
        else
        {
            return
        }
        
        mappedItem.skProduct = skProduct
        priceFormatter.locale = skProduct.priceLocale
        
        let priceNumber:NSDecimalNumber = skProduct.price
        let priceString:String? = priceFormatter.string(from:priceNumber)
        mappedItem.price = priceString
    }
    
    func updateTransactions(transactions:[SKPaymentTransaction])
    {
        for skPaymentTransaction:SKPaymentTransaction in transactions
        {
            let productId:String = skPaymentTransaction.payment.productIdentifier
            
            guard
                
                let mappedItem:MStorePurchaseItem = mapItems[productId]
            
            else
            {
                continue
            }
            
            switch skPaymentTransaction.transactionState
            {
                case SKPaymentTransactionState.deferred:
                    
                    mappedItem.status = MStorePurchaseItemStatusDeferred()
                    
                    break
                    
                case SKPaymentTransactionState.failed:
                    
                    mappedItem.status = MStorePurchaseItemStatusNew()
                    SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
                    
                    break
                    
                case SKPaymentTransactionState.purchased,
                     SKPaymentTransactionState.restored:
                    
                    mappedItem.purchased()
                    SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
                    
                    break
                    
                case SKPaymentTransactionState.purchasing:
                    
                    mappedItem.status = MStorePurchaseItemStatusPurchasing()
                    
                    break
            }
        }
    }
}
