import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics
    
    private init()
    {
        FIRApp.configure()
        
        analytics = FAnalytics()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
