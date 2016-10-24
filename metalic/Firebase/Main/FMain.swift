import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    
    private init()
    {
        FIRApp.configure()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
