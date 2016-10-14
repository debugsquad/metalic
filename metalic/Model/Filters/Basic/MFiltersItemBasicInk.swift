import Foundation

class MFiltersItemBasicInk:MFiltersItem
{
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicInk_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicInk.self
        
        super.init(name:name, filter:filter)
    }
}
