import Foundation

class MFiltersItemPremiumEmber:MFiltersItem
{
    private let kImageName:String = "assetFilterEmber"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemPremiumEmber_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterPremiumEmber.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
