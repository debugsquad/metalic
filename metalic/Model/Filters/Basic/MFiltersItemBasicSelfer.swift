import Foundation

class MFiltersItemBasicSelfer:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicSelfer_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicSelfer.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
