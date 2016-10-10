import UIKit

class CHome:CController
{
    weak var viewHome:VHome!
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}
