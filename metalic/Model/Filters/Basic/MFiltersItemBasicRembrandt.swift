import Foundation

class MFiltersItemBasicRembrandt:MFiltersItem
{
    private let kImageName:String = "assetFilterRembrandt"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicRembrandt_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicRembrandt.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
