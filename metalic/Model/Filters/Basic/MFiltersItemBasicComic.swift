import Foundation

class MFiltersItemBasicComic:MFiltersItem
{
    private let kImageName:String = "assetFilterComic"
    private let kCommitable:Bool = true
    
    required init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicComic_name", comment:"")
        let filter:MetalFilter.Type = MetalFilterBasicComic.self
        
        super.init(name:name, asset:kImageName, filter:filter, commitable:kCommitable)
    }
}
