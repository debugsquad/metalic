import Foundation

class MFiltersItemPremiumSelfer:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemPremiumSelfer_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterPremiumSelfer.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
