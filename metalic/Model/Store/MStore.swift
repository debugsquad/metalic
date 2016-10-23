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
    
}
