import UIKit

class MEditItemCrop:MEditItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetEditCrop").withRenderingMode(UIImageRenderingMode.alwaysTemplate))
    }
    
    override func selected(controller:CHomeEdit)
    {
        controller.viewEdit.cropMode()
    }
}
