import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:String = "Screen"
    
    //MARK: public
    
    func screen(controller:CController)
    {
        let className:NSObject = controller.name as NSObject
        let eventScreen:NSObject = kEventScreen as NSObject
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterItemID:eventScreen,
                kFIRParameterItemName:className
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventViewItem,
                parameters:parameters)
        }
    }
}
