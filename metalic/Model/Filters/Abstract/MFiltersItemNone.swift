import Foundation

class MFiltersItemNone:MFiltersItem
{
    private let kImageName:String = "assetFilterNone"
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemNone_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterNone.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
