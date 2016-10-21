import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    static let appId:String = "1168066325"

    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]?) -> Bool
    {
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        let parent:CParent = CParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
}
