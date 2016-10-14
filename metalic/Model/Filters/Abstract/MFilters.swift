import Foundation

class MFilters
{
    var items:[MFiltersItem]
    
    init()
    {
        self.items = []
        
        var items:[MFiltersItem] = []
        items.append(contentsOf:basicFilters())
        items.append(contentsOf:premiumFilters())
        
        self.items = items
    }
    
    //MARK: private
    
    private func basicFilters() -> [MFiltersItem]
    {
        let itemInk:MFiltersItemBasicInk = MFiltersItemBasicInk()
        
        let items:[MFiltersItem] = [
            itemInk
        ]
        
        return items
    }
    
    private func premiumFilters() -> [MFiltersItem]
    {
        let items:[MFiltersItem] = [
        ]
        
        return items
    }
}
