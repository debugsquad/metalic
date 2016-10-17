import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private let kFunctionName:String = "filter_basicSelfer"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func specialConfig()
    {
        let context:CIContext = CIContext()
        let options:[String:Any] = [
            CIDetectorAccuracy:CIDetectorAccuracyHigh
        ]
        
        guard
        
            let detector:CIDetector = CIDetector(
                ofType:CIDetectorTypeFace,
                context:context,
                options:options)
        
        else
        {
            return
        }
        
        guard
            
            let uiImage:UIImage = sourceTexture?.exportImage()
            
            else
        {
            return
        }
        
        guard
            
            let image:CIImage = CIImage(image:uiImage)
        
        else
        {
            return
        }
        
        let features:[CIFeature] = detector.features(in:image)
        
        for feature:CIFeature in features
        {
            guard
            
                let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            
            else
            {
                continue
            }
            
            print(faceFeature.bounds)
        }
        
        /*
 
 
         CIContext *context = [CIContext context];                    // 1
         NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };      // 2
         CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
         context:context
         options:opts];                    // 3
         
         opts = @{ CIDetectorImageOrientation :
         [[myImage properties] valueForKey:kCGImagePropertyOrientation] }; // 4
         NSArray *features = [detector featuresInImage:myImage options:opts];        // 5
 
 */
    }
}
