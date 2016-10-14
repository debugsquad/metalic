import Foundation

class MFiltersItemBasicNone:MFiltersItem
{
    private let kImageName:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MFiltersItemBasicNone_name", comment:"")
        
        super.init(name:name, asset:kImageName, filter:nil)
    }
}
