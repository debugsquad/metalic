import UIKit
import MetalKit

class CHomeFiltered:CController
{
    weak var viewFiltered:VHomeFiltered!
    weak var home:CHome!
    let texture:MTLTexture
    let filter:MetalFilter
    
    init(home:CHome, texture:MTLTexture, filter:MetalFilter)
    {
        self.texture = texture
        self.filter = filter
        
        super.init(nibName:nil, bundle:nil)
        self.home = home
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewFiltered.viewPicture.draw()
    }
}
