import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:NSString = "Screen"
    private let kEventAction:NSString = "Action"
    private let kEventActionShare:NSString = "Share"
    
    //MARK: public
    
    func screen(controller:CController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterItemID:self.kEventScreen,
                kFIRParameterItemName:controller.name
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventViewItem,
                parameters:parameters)
        }
    }
    
    func share()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterItemID:self.kEventScreen,
                kFIRParameterItemName:self.kEventActionShare
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventViewItem,
                parameters:parameters)
        }
    }
}
