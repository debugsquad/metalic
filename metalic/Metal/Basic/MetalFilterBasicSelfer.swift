import MetalPerformanceShaders
import CoreImage

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
        
        let detector:CIDetector? = CIDetector(ofType:CIDetectorTypeFace, context:context
            , options:options)
        self.sourceTexture.ima
        detector?.features(in: <#T##CIImage#>)
        
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
