import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics
    
    private init()
    {
        #if DEBUG
            
            print("Started analytics")
            
        #else
            
            FIRApp.configure()
        
        #endif
        
        analytics = FAnalytics()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
