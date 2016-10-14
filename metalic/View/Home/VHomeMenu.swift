import UIKit

class VHomeMenu:UIView
{
    weak var controller:CHome!
    let model:MFilters
    
    init(controller:CHome)
    {
        model = MFilters()
        
        super.init(frame:CGRect.zero)
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
