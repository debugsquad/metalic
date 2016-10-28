import Foundation

class MMain
{
    let items:[MMainItem]
    var state:MMainState
    weak var current:MMainItem!
    
    init()
    {
        state = MMainStateOptions()
        
        var items:[MMainItem] = []
        
        let itemHome:MMainItemHome = MMainItemHome(index:items.count)
        current = itemHome
        items.append(itemHome)
        let itemStore:MMainItemStore = MMainItemStore(index:items.count)
        items.append(itemStore)
        
        self.items = items
    }
    
    //MARK: public
    
    func pushed()
    {
        state = MMainStatePushed()
    }
    
    func poped()
    {
        state = MMainStateOptions()
    }
}
