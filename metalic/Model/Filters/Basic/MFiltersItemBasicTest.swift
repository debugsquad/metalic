import Foundation

class MFiltersItemBasicTest:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicTest_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicTest.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
