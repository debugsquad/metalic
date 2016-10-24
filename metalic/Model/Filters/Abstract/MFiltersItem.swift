import Foundation

class MFiltersItem
{
    let filter:MetalFilter.Type
    let name:String
    let asset:String
    let commitable:Bool
    
    class func Factory(className:String) -> MFiltersItem?
    {
        guard
            
            let bundleName:String = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
            let classType:AnyObject.Type = NSClassFromString(String(format:"%@.%@", bundleName, className)),
            let filterClass:MFiltersItem.Type = classType as? MFiltersItem.Type
            
        else
        {
            return nil
        }
        
        let filterItem:MFiltersItem = filterClass.init()
        
        return filterItem
    }
    
    required init()
    {
        fatalError()
    }
    
    init(name:String, asset:String, filter:MetalFilter.Type, commitable:Bool)
    {
        self.name = name
        self.asset = asset
        self.filter = filter
        self.commitable = commitable
    }
}
