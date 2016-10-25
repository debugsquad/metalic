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
            
            let filterItem:MFiltersItem? = MFiltersItem.Factory(className:rawPurchaseClass!)
            
            XCTAssertNotNil(filterItem, "Unable to factory filter class")
        }
    }
}
