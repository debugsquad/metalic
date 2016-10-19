import Foundation

class MFiltersItemPremiumNeon:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemPremiumNeon_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterPremiumNeon.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
