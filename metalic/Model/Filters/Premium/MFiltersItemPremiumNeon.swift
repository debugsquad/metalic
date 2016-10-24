import Foundation

class MFiltersItemPremiumNeon:MFiltersItem
{
    private let kImageName:String = "assetFilterNeon"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemPremiumNeon_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterPremiumNeon.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
