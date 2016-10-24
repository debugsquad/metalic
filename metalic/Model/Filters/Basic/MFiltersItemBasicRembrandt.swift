import Foundation

class MFiltersItemBasicRembrandt:MFiltersItem
{
    private let kImageName:String = "assetFilterRembrandt"
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicRembrandt_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicRembrandt.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
