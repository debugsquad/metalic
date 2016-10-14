import Foundation

class MFiltersItemBasicNone:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicNone_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicNone.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
