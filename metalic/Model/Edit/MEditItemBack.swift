import UIKit

class MEditItemBack:MEditItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate))
    }
    
    override func selected(controller:CHomeEdit)
    {
        controller.parentController.dismiss()
    }
}
