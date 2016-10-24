import Foundation

class MFilters
{
    var items:[MFiltersItem]
    private var dbFilters:[DObjectPurchase]
    private var premiumFilters:[MFiltersItem]
    private let kResourcesName:String = "Purchases"
    private let kResourcesExtension:String = "plist"
    private let kPurchaseIdKey:String = "purchaseId"
    private let kPurchaseClassKey:String = "purchaseClass"
    
    init()
    {
        items = []
        premiumFilters = []
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
        let rawPurchases:[[String:String]] = NSArray(contentsOf:resURL) as! [[String:String]]
        
        for rawPurchase:[String:String] in rawPurchases
        {
            var dbFilterStored:DObjectPurchase?
            let rawPurchaseId:String = rawPurchase[kPurchaseIdKey]!
            let rawPurchaseClass:String = rawPurchase[kPurchaseClassKey]!
            
            for dbFilter:DObjectPurchase in dbFilters
            {
                if dbFilter.purchaseId == rawPurchaseId
                {
                    dbFilterStored = dbFilter
                    
                    break
                }
            }
            
            if dbFilterStored == nil
            {
                DManager.sharedInstance.createManagedObject(
                    modelType:DObjectPurchase.self)
                { (object) in
                    
                    object.purchaseId = rawPurchaseId
                    object.purchaseClass = rawPurchaseClass
                    DManager.sharedInstance.save()
                }
            }
            else
            {
                if dbFilterStored!.purchased
                {
                    guard
                        
                        let filterItem:MFiltersItem = MFiltersItem.Factory(
                            className:rawPurchaseClass)
                    
                    else
                    {
                        continue
                    }
                    
                    premiumFilters.append(filterItem)
                }
            }
        }
        
        fillItems()
        NotificationCenter.default.post(
            name:Notification.filtersLoaded,
            object:nil)
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
    
    private func fillItems()
    {
        self.items = []
        
        let itemNone:MFiltersItemNone = MFiltersItemNone()
        
        var items:[MFiltersItem] = [
            itemNone
        ]
        
        items.append(contentsOf:premiumFilters)
        items.append(contentsOf:basicFilters())
        
        self.items = items
    }
}
