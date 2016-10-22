import Foundation

class MFiltersItemBasicGothic:MFiltersItem
{
    private let kImageName:String = ""
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicGothic_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicGothic.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
