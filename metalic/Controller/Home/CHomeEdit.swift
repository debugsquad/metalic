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
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        viewEdit.viewCrop.willChangeSize()
    }
    
    //MARK: public
    
    func cropImage(percentLeft:CGFloat, percentRight:CGFloat, percentTop:CGFloat, percentBottom:CGFloat)
    {
        
        /*
        
        guard
        -
        -            let normalizedImage:UIImage = normalizedImage,
        -            let normalizedCGImage:CGImage = normalizedImage.cgImage
        -
        -        else
        -        {
            -            return nil
            -        }
            -
        -        let imageWidth:CGFloat = normalizedImage.size.width
        -        let imageHeight:CGFloat = normalizedImage.size.height
        -        let usableWidthScaleInt:Int = Int(width)
        -        let usableHeightScaleInt:Int = Int(height)
        -        let bitsPerComponent:Int = normalizedCGImage.bitsPerComponent
        -        let bitmapInfo:CGBitmapInfo = normalizedCGImage.bitmapInfo
        -        let colorSpace:CGColorSpace? = normalizedCGImage.colorSpace
        -        var bytesPerRow:Int = normalizedCGImage.bytesPerRow
        -        let drawRect:CGRect
        -        let drawWidth:Int
        -        let drawHeight:Int
        -        let drawX:Int
        -        let drawY:Int
        -
        -        if width < imageWidth || height < imageHeight
        -        {
        -            let ratioWidth:CGFloat = imageWidth / width
        -            let ratioHeight:CGFloat = imageHeight / height
        -            let maxRatio:CGFloat = max(ratioWidth, ratioHeight)
        -            let scaledWidth:CGFloat = floor(imageWidth / maxRatio)
        -            let scaledHeight:CGFloat = floor(imageHeight / maxRatio)
        -            let deltaWidth:CGFloat = width - scaledWidth
        -            let deltaHeight:CGFloat = height - scaledHeight
        -            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
        -            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
        -            drawX = Int(drawXFloat)
        -            drawY = Int(drawYFloat)
        -            drawWidth = Int(scaledWidth)
        -            drawHeight = Int(scaledHeight)
        -        }
        -        else
        -        {
            -            let deltaWidth:CGFloat = width - imageWidth
            -            let deltaHeight:CGFloat = height - imageHeight
            -            let drawXFloat:CGFloat = floor(deltaWidth / 2.0)
            -            let drawYFloat:CGFloat = floor(deltaHeight / 2.0)
            -            drawX = Int(drawXFloat)
            -            drawY = Int(drawYFloat)
            -            drawWidth = Int(imageWidth)
            -            drawHeight = Int(imageHeight)
            -        }
            -
        -        if bytesPerRow < kMinBytesPerRow
        -        {
        -            bytesPerRow = kMinBytesPerRow
        -        }
        -
        -        drawRect = CGRect(x:drawX, y:drawY, width:drawWidth, height:drawHeight)
        -
        -        guard
        -
        -            let realColorSpace:CGColorSpace = colorSpace,
        -            let context:CGContext = CGContext.init(
        -                data:nil,
        -                width:usableWidthScaleInt,
        -                height:usableHeightScaleInt,
        -                bitsPerComponent:bitsPerComponent,
        -                bytesPerRow:bytesPerRow,
        -                space:realColorSpace,
        -                bitmapInfo:bitmapInfo.rawValue)
        -        
        -        else
        -        {
            -            return nil
            -        }
            -        
            -        context.interpolationQuality = CGInterpolationQuality.high
            -        context.draw(
            -            normalizedCGImage,
            -            in:drawRect)
            -        
        -        let cgImage:CGImage? = context.makeImage()
        -        
        -        return cgImage
 
 
 */
 
    }
}
