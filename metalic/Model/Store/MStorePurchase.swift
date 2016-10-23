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
        let mappedItem:MStorePurchaseItem? = mapItems[productId]
        
        if mappedItem != nil
        {
            mappedItem!.skProduct = skProduct
            priceFormatter.locale = skProduct.priceLocale
            
            let priceNumber:NSDecimalNumber = skProduct.price
            let priceString:String? = priceFormatter.string(from:priceNumber)
            mappedItem!.price = priceString
        }
    }
    
}

/*

 
 
 -(void)updatetransactions:(NSArray<SKPaymentTransaction*>*)transactions
 {
 NSUInteger qty = transactions.count;
 for(NSUInteger i = 0; i < qty; i++)
 {
 SKPaymentTransaction *tran = transactions[i];
 NSString *prodid = tran.payment.productIdentifier;
 mstorepurchasesitem *item = self.dictitems[prodid];
 
 if(item)
 {
 switch(tran.transactionState)
 {
 case SKPaymentTransactionStateDeferred:
 
 item.status = [[mstorestatusdeferred alloc] init];
 
 break;
 
 case SKPaymentTransactionStateFailed:
 
 item.status = [[mstorestatusnew alloc] init];
 [[SKPaymentQueue defaultQueue] finishTransaction:tran];
 
 break;
 
 case SKPaymentTransactionStatePurchased:
 
 item.status = [[mstorestatuspurchased alloc] init];
 [mcourse opencourse:NSClassFromString(item.courseclass)];
 [[SKPaymentQueue defaultQueue] finishTransaction:tran];
 
 break;
 
 case SKPaymentTransactionStatePurchasing:
 
 item.status = [[mstorestatuspurchasing alloc] init];
 
 break;
 
 case SKPaymentTransactionStateRestored:
 
 item.status = [[mstorestatuspurchased alloc] init];
 [mcourse opencourse:NSClassFromString(item.courseclass)];
 [[SKPaymentQueue defaultQueue] finishTransaction:tran];
 
 break;
 }
 }
 }
 }

 
 */
