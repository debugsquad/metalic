import Foundation
import StoreKit

class MStore:SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    static let sharedInstance:MStore = MStore()
    let purchase:MStorePurchase
    var error:String?
    
    private init()
    {
        purchase = MStorePurchase()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    @objc func notifiedPurchasesLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.main.async
        {
            self.checkAvailability()
        }
    }
    
    //MARK: private
    
    private func notifyStore()
    {
        NotificationCenter.default.post(
            name:Notification.storeLoaded,
            object:nil)
    }
    
    //MARK: public
    
    func checkAvailability()
    {
        error = nil
        
        if purchase.mapItems.count > 0
        {
            let itemsSet:Set<String> = purchase.makeSet()
            let request:SKProductsRequest = SKProductsRequest(productIdentifiers:itemsSet)
            request.delegate = self
            request.start()
        }
        else
        {
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(notifiedPurchasesLoaded(sender:)),
                name:Notification.purchasesLoaded,
                object:nil)
        }
    }
    
    func restorePurchases()
    {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    //MARK: store delegate
    
    func request(_ request:SKRequest, didFailWithError error:Error)
    {
        self.error = error.localizedDescription
        notifyStore()
    }
    
    func productsRequest(_ request:SKProductsRequest, didReceive response:SKProductsResponse)
    {
        let products:[SKProduct] = response.products
        
        for product:SKProduct in products
        {
            
        }
        
        
        NSArray *products = response.products;
        NSInteger qty = products.count;
        
        for(NSUInteger i = 0; i < qty; i++)
        {
            SKProduct *skproduct = products[i];
            [self.purchases loadskproduct:skproduct];
        }
        
        [self restorepurchases];
        
    }
}
