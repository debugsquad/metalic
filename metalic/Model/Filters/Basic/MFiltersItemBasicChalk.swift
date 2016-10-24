import Foundation

class MFiltersItemBasicChalk:MFiltersItem
{
    private let kImageName:String = "assetFilterChalk"
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicChalk_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicChalk.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
