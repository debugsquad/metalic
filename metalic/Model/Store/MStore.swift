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
    
    func notifiedPurchasesLoaded(sender notification:Notification)
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
            
        }
        else
        {
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(notifiedPurchasesLoaded(sender:)),
                name:Notification.purchasesLoaded,
                object:nil)
        }
        
        let itemsSet:Set<String> = 
        let request:SKProductsRequest = SKProductsRequest(productIdentifiers: <#T##Set<String>#>)
        
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.purchases.asset];
        request.delegate = self;
        [request start];
    }
    
    func restorePurchases()
    {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    //MARK: store delegate
    
}
