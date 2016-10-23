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
    
    //MARK: public
    
    func checkAvailability()
    {
        error = nil
        
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
