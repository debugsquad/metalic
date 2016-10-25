import XCTest
@testable import metalic

class TMFilters:XCTestCase
{
    func testPurchasesList()
    {
        let mFilters:MFilters = MFilters()
        let purchasesList:[[String:String]]? = mFilters.purchasesList()
        
        XCTAssertNotNil(purchasesList, "Unabled to load purchases list")
    }
}
