import Foundation
import StoreKit

class MStore:NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    static let sharedInstance:MStore = MStore()
    let purchase:MStorePurchase
    var error:String?
    
    override init()
    {
        purchase = MStorePurchase()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    func notifiedPurchasesLoaded(sender notification:Notification)
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
            
            purchase.loadDb()
        }
    }
    
    func restorePurchases()
    {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func purchase(skProduct:SKProduct?)
    {
        guard
            
            let skProduct:SKProduct = skProduct
        
        else
        {
            return
        }
        
        let skPayment:SKPayment = SKPayment(product:skProduct)
        SKPaymentQueue.default().add(skPayment)
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
            purchase.loadSkProduct(skProduct:product)
        }
        
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, updatedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, removedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        notifyStore()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue:SKPaymentQueue)
    {
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, restoreCompletedTransactionsFailedWithError error:Error)
    {
        self.error = error.localizedDescription
        notifyStore()
    }
}
