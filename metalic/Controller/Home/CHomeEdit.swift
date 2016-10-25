import UIKit

class CHomeEdit:CController
{
    weak var viewEdit:VHomeEdit!
    
    override func loadView()
    {
        let viewEdit:VHomeEdit = VHomeEdit(controller:self)
        self.viewEdit = viewEdit
        view = viewEdit
    }
}
