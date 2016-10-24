import Foundation

class MFiltersItemPremiumSelfer:MFiltersItem
{
    private let kImageName:String = "assetFilterSelfer"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemPremiumSelfer_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterPremiumSelfer.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
