import UIKit

class CHomeEdit:CController
{
    weak var viewEdit:VHomeEdit!
    weak var filtered:CHomeFiltered!
    private let kMinBytesPerRow:Int = 3000
    
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
        guard
        
            let cgImage:CGImage = filtered.image.cgImage
        
        else
        {
            viewEdit.endCropMode()
            
            return
        }
        
        let imageOriginalWidth:CGFloat = filtered.image.size.width
        let imageOriginalHeight:CGFloat = filtered.image.size.height
        let imageOriginalWidthInt:Int = Int(imageOriginalWidth)
        let imageOriginalHeightInt:Int = Int(imageOriginalHeight)
        let deltaLeft:Int = Int(ceil(percentLeft))
        let deltaRight:Int = Int(ceil(percentRight))
        let deltaTop:Int = Int(ceil(percentTop))
        let deltaBottom:Int = Int(ceil(percentBottom))
        let deltaHorizontal:Int = deltaLeft + deltaRight
        let deltaVertical:Int = deltaTop + deltaBottom
        let expectedWidth:Int = imageOriginalWidthInt - deltaHorizontal
        let expectedHeight:Int = imageOriginalHeightInt - deltaVertical
        let bitsPerComponent:Int = cgImage.bitsPerComponent
        let bitmapInfo:CGBitmapInfo = cgImage.bitmapInfo
        var bytesPerRow:Int = cgImage.bytesPerRow
        let drawRect:CGRect = CGRect(
            x:-deltaLeft,
            y:-deltaTop,
            width:imageOriginalWidthInt,
            height:imageOriginalHeightInt)
        
        if bytesPerRow < kMinBytesPerRow
        {
            bytesPerRow = kMinBytesPerRow
        }
        
        guard
        
            let colorSpace:CGColorSpace = cgImage.colorSpace,
            let context:CGContext = CGContext.init(
                data:nil,
                width:expectedWidth,
                height:expectedHeight,
                bitsPerComponent:bitsPerComponent,
                bytesPerRow:bytesPerRow,
                space:colorSpace,
                bitmapInfo:bitmapInfo.rawValue)
        
        else
        {
            viewEdit.endCropMode()
            
            return
        }
        
        context.interpolationQuality = CGInterpolationQuality.high
        context.draw(
            cgImage,
            in:drawRect)
        
        guard
        
            let editedImage:CGImage = context.makeImage()
        
        else
        {
            viewEdit.endCropMode()
            
            return
        }
        
        let resultImage:UIImage = UIImage(cgImage:editedImage)
        filtered.image = resultImage
        filtered.viewFiltered.imageView.image = resultImage
        filtered.viewFiltered.background.image = resultImage
        viewEdit.imageView.image = resultImage
        
        viewEdit.endCropMode()
    }
}
