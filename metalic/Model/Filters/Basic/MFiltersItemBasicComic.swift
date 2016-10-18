import Foundation

class MFiltersItemBasicComic:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicComic_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicComic.self
        
        super.init(name:name, asset:kImageName, filter:filter)
    }
}
