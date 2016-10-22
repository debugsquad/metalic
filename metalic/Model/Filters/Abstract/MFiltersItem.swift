import Foundation

class MFiltersItem
{
    let filter:MetalFilter.Type
    let name:String
    let asset:String
    
    required init()
    {
    }
    
    init(name:String, asset:String, filter:MetalFilter.Type)
    {
        self.name = name
        self.asset = asset
        self.filter = filter
    }
}
