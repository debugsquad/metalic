import Foundation

class MFiltersItem
{
    let filter:MetalFilter.Type
    let name:String
    let asset:String
    
    init(name:String, asset:String, filter:MetalFilter.Type)
    {
        self.name = name
        self.asset = asset
        self.filter = filter
    }
}
