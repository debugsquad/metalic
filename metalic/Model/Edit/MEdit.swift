import Foundation

class MEdit
{
    let items:[MEditItem]
    
    init()
    {
        let itemBack:MEditItemBack = MEditItemBack()
        let itemCrop:MEditItemCrop = MEditItemCrop()
        
        items = [
            itemBack,
            itemCrop
        ]
    }
}
