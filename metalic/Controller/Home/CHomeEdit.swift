import UIKit

class CHomeEdit:CController
{
    weak var viewEdit:VHomeEdit!
    weak var filtered:CHomeFiltered!
    
    convenience init(filtered:CHomeFiltered)
    {
        self.init()
        self.filtered = filtered
    }
    
    override func loadView()
    {
        let viewEdit:VHomeEdit = VHomeEdit(controller:self)
        self.viewEdit = viewEdit
        view = viewEdit
    }
}
