import UIKit

class CHomeFiltered:CController
{
    weak var viewFiltered:VHomeFiltered!
    
    override func loadView()
    {
        let viewFiltered:VHomeFiltered = VHomeFiltered(controller:self)
        self.viewFiltered = viewFiltered
        view = viewFiltered
    }
}
