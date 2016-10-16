import Foundation

class MFiltersItemBasicRembrandt:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicRembrandt_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicRembrandt.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
