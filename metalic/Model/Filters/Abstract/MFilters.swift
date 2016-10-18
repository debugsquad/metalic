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
        let itemNone:MFiltersItemBasicNone = MFiltersItemBasicNone()
        let itemInk:MFiltersItemBasicInk = MFiltersItemBasicInk()
        let itemGothic:MFiltersItemBasicGothic = MFiltersItemBasicGothic()
        let itemRembrandt:MFiltersItemBasicRembrandt = MFiltersItemBasicRembrandt()
        let itemSelfer:MFiltersItemBasicSelfer = MFiltersItemBasicSelfer()
        let itemComic:MFiltersItemBasicComic = MFiltersItemBasicComic()
        let itemTest:MFiltersItemBasicTest = MFiltersItemBasicTest()
        let itemChalk:MFiltersItemBasicChalk = MFiltersItemBasicChalk()
        
        let items:[MFiltersItem] = [
            itemNone,
            itemChalk,
            itemTest,
            itemComic,
            itemInk,
            itemGothic,
            itemRembrandt,
            itemSelfer
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
