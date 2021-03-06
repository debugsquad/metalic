import Foundation

class MFiltersItemBasicInk:MFiltersItem
{
    private let kImageName:String = "assetFilterInk"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicInk_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicInk.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
