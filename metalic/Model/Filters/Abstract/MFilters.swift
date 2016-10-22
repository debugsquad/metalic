import Foundation

class MFilters
{
    var items:[MFiltersItem]
    var dbFilters:[DObjectPurchase]
    private let kResourcesName:String = "Purchases"
    private let kResourcesExtension:String = "plist"
    
    init()
    {
        items = []
        dbFilters = []
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadDb()
        }
    }
    
    //MARK: private
    
    private func loadDb()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectPurchase.self)
        { [weak self] (objects) in
            
            self?.dbFilters = objects
            self?.loadResources()
        }
    }
    
    private func loadResources()
    {
        let resURL:URL = Bundle.main.url(
            forResource:kResourcesName,
            withExtension:kResourcesExtension)!
        let rawPurchases:[String] = NSArray(contentsOf:resURL) as! [String]
        
        for rawPurchase:String in rawPurchases
        {
            var found:Bool = false
            
            for dbFilter:DObjectPurchase in dbFilters
            {
                if dbFilter.purchaseId == rawPurchase
                {
                    found = true
                    
                    break
                }
            }
            
            if !found
            {
                DManager.sharedInstance.createManagedObject(
                    modelType:DObjectPurchase.self)
                { (object) in
                    
                    object.purchaseId = rawPurchase
                }
            }
        }
    }
    
    private func basicFilters() -> [MFiltersItem]
    {
        let _:MFiltersItemBasicTest = MFiltersItemBasicTest()
        let itemInk:MFiltersItemBasicInk = MFiltersItemBasicInk()
        let itemGothic:MFiltersItemBasicGothic = MFiltersItemBasicGothic()
        let itemRembrandt:MFiltersItemBasicRembrandt = MFiltersItemBasicRembrandt()
        let itemComic:MFiltersItemBasicComic = MFiltersItemBasicComic()
        let itemChalk:MFiltersItemBasicChalk = MFiltersItemBasicChalk()
        let itemDefine:MFiltersItemBasicDefine = MFiltersItemBasicDefine()
        
        let items:[MFiltersItem] = [
            itemDefine,
            itemChalk,
            itemComic,
            itemInk,
            itemGothic,
            itemRembrandt
        ]
        
        return items
    }
    
    private func premiumFilters() -> [MFiltersItem]
    {
        let itemNeon:MFiltersItemPremiumNeon = MFiltersItemPremiumNeon()
        let itemEmber:MFiltersItemPremiumEmber = MFiltersItemPremiumEmber()
        let itemSelfer:MFiltersItemPremiumSelfer = MFiltersItemPremiumSelfer()
        
        let items:[MFiltersItem] = [
            itemNeon,
            itemEmber,
            itemSelfer
        ]
        
        return items
    }
    
    private func fillItems()
    {
        self.items = []
        
        let itemNone:MFiltersItemNone = MFiltersItemNone()
        
        var items:[MFiltersItem] = [
            itemNone
        ]
        
        items.append(contentsOf:premiumFilters())
        items.append(contentsOf:basicFilters())
        
        self.items = items
    }
}
