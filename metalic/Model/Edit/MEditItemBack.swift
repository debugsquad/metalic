import UIKit

class MEditItemBack:MEditItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate))
    }
    
    override func selected(controller:CHomeEdit)
    {
        controller.dismiss(
            animated:true,
            completion:nil)
    }
}
