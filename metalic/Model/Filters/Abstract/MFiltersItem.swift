import Foundation

class MFiltersItem
{
    let filter:MetalFilter.Type
    let name:String
    
    init(name:String, filter:MetalFilter.Type)
    {
        self.name = name
        self.filter = filter
    }
}
