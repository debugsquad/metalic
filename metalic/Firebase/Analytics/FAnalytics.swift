import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:NSString = "Screen"
    private let kEventAction:NSString = "Action"
    private let kEventActionShare:NSString = "Share"
    private let kEventActionCrop:NSString = "Crop"
    
    //MARK: public
    
    func screen(controller:CController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventScreen,
                kFIRParameterItemID:controller.name
            ]
            
            #if DEBUG

                print(parameters)
            
            #else
                
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
                
            #endif
        }
    }
    
    func share()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventAction,
                kFIRParameterItemID:self.kEventActionShare
            ]
            
            #if DEBUG
            
                print(parameters)
                
            #else
                
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)

            #endif
        }
    }
    
    func crop()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventAction,
                kFIRParameterItemID:self.kEventActionCrop
            ]
            
            #if DEBUG
                
                print(parameters)
                
            #else
                
                FIRAnalytics.logEvent(
                    withName:kFIREventSelectContent,
                    parameters:parameters)
                
            #endif
        }
    }
}
