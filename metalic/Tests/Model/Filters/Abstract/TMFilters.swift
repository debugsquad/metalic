import XCTest
@testable import metalic

class TMFilters:XCTestCase
{
    func testPurchasesList()
    {
        let mFilters:MFilters = MFilters()
        let purchasesList:[[String:String]]? = mFilters.purchasesList()
        
        XCTAssertNotNil(purchasesList, "Unabled to load purchases list")
        XCTAssertGreaterThan(purchasesList!.count, 0, "Empty purchases list")
        
        for rawPurchase:[String:String] in purchasesList!
        {
            let rawPurchaseId:String? = rawPurchase[mFilters.kPurchaseIdKey]
            let rawPurchaseClass:String? = rawPurchase[mFilters.kPurchaseClassKey]
            
            XCTAssertNotNil(rawPurchaseId, "Couldn't parse purchase id")
            XCTAssertNotNil(rawPurchaseClass, "Couldn't parser purchase class")
            
            
            
            for dbFilter:DObjectPurchase in dbFilters
            {
                if dbFilter.purchaseId == rawPurchaseId
                {
                    dbFilterStored = dbFilter
                    
                    break
                }
            }
            
            if dbFilterStored == nil
            {
                DManager.sharedInstance.createManagedObject(
                    modelType:DObjectPurchase.self)
                { (object) in
                    
                    object.purchaseId = rawPurchaseId
                    object.purchaseClass = rawPurchaseClass
                    DManager.sharedInstance.save()
                }
            }
            else
            {
                if dbFilterStored!.purchased
                {
                    guard
                        
                        let filterItem:MFiltersItem = MFiltersItem.Factory(
                            className:rawPurchaseClass)
                        
                        else
                    {
                        continue
                    }
                    
                    premiumFilters.append(filterItem)
                }
            }
        }
    }
}
