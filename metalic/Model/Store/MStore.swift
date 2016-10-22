import Foundation
import StoreKit

class MStore, skprod
{
    //SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
    static let sharedInstance:MStore = MStore()
    var error:String?
    
    //MARK: public
    
    func checkAvailability()
    {
        error = nil
        
        let request:SKProductsRequest = SKProductsRequest.init(productIdentifiers:)
        
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
