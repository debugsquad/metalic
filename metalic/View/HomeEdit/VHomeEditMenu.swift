import UIKit

class VHomeEditMenu:UIView
{
    weak var controller:CHomeEdit!
    let model:MEdit
    
    init(controller:CHomeEdit)
    {
        model = MEdit()
        
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
