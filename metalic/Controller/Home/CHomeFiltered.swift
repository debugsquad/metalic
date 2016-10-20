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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = NSLocalizedString("CHomeFiltered_title", comment:"")
    }
    
    //MARK: public
    
    func export()
    {
        let activity:UIActivityViewController = UIActivityViewController(activityItems:[image], applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewFiltered
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
