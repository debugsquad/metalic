import UIKit

class VHomeEditCropOverlay:UIView
{
    enum BorderPosition
    {
        case none
        case top
        case bottom
        case left
        case right
    }
    
    private let kAlpha:CGFloat = 0.7
    private let kBorderSize:CGFloat = 2
    private let kEmpty:String = ""
    
    convenience init(borderPosition:BorderPosition)
    {
        self.init()
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0, alpha:kAlpha)
        clipsToBounds = true
        
        if borderPosition != BorderPosition.none
        {
            let border:UIView = UIView()
            border.isUserInteractionEnabled = false
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = UIColor.white
            border.clipsToBounds = true
            
            addSubview(border)
            
            let visualFormatH:String
            let visualFormatV:String
            
            let views:[String:UIView] = [
                "border":border]
            
            let metrics:[String:CGFloat] = [
                "borderSize":kBorderSize]
            
            switch borderPosition
            {
                case BorderPosition.none:
                    
                    visualFormatH = kEmpty
                    visualFormatV = kEmpty
                    
                    break
                    
                case BorderPosition.top:
                    
                    visualFormatH = "H:|-0-[border]-0-|"
                    visualFormatV = "V:[border(borderSize)]-0-|"
                    
                    break
                    
                case BorderPosition.left:
                    
                    visualFormatH = "H:[border(borderSize)]-0-|"
                    visualFormatV = "V:|-0-[border]-0-|"
                    
                    break
                    
                case BorderPosition.bottom:
                    
                    visualFormatH = "H:|-0-[border]-0-|"
                    visualFormatV = "V:|-0-[border(borderSize)]"
                    
                    break
                    
                case BorderPosition.right:
                    
                    visualFormatH = "H:|-0-[border(borderSize)]"
                    visualFormatV = "V:|-0-[border]-0-|"
                    
                    break
            }
            
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:visualFormatH,
                options:[],
                metrics:metrics,
                views:views))
            
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:visualFormatV,
                options:[],
                metrics:metrics,
                views:views))
        }
    }
}
