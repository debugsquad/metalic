import Foundation

class MFiltersItemBasicDefine:MFiltersItem
{
    private let kImageName:String = "assetFilterDefine"
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicDefine_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicDefine.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
