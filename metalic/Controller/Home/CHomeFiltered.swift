import UIKit
import MetalKit

class CHomeFiltered:CController
{
    weak var viewFiltered:VHomeFiltered!
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewFiltered:VHomeFiltered = VHomeFiltered(controller:self)
        self.viewFiltered = viewFiltered
        view = viewFiltered
    }
}
