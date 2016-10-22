import Foundation

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
}

/*
 
 #pragma mark public
 
 -(void)loadskproduct:(SKProduct*)skproduct
 {
 NSDictionary *dicttitle = @{NSFontAttributeName:[UIFont fontWithName:fontboldname size:itemtitlesize], NSForegroundColorAttributeName:colormain};
 NSDictionary *dictdescr = @{NSFontAttributeName:[UIFont fontWithName:fontregularname size:itemdescrsize], NSForegroundColorAttributeName:colorthird};
 NSDictionary *dictprice = @{NSFontAttributeName:[UIFont fontWithName:fontboldname size:itempricesize], NSForegroundColorAttributeName:[UIColor blackColor]};
 
 NSString *prodid = skproduct.productIdentifier;
 mstorepurchasesitem *initem = self.dictitems[prodid];
 
 if(initem)
 {
 [self.priceformater setLocale:skproduct.priceLocale];
 NSString *strprice = [self.priceformater stringFromNumber:skproduct.price];
 initem.pricestring = strprice;
 initem.skproduct = skproduct;
 
 NSString *stringtitle = initem.itemtitle;
 NSString *stringdescr = [NSString stringWithFormat:@"\n%@", initem.itemdescr];
 NSString *stringprice = [NSString stringWithFormat:@"\n%@", strprice];
 
 NSAttributedString *attrtitle = [[NSAttributedString alloc] initWithString:stringtitle attributes:dicttitle];
 NSAttributedString *attrdescr = [[NSAttributedString alloc] initWithString:stringdescr attributes:dictdescr];
 NSAttributedString *attrprice = [[NSAttributedString alloc] initWithString:stringprice attributes:dictprice];
 
 NSMutableAttributedString *mut = [[NSMutableAttributedString alloc] init];
 [mut appendAttributedString:attrtitle];
 [mut appendAttributedString:attrdescr];
 [mut appendAttributedString:attrprice];
 initem.attributestring = mut;
 }
 }
 
 
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
