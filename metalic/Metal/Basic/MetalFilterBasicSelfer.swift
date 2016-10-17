import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private let kFunctionName:String = "filter_basicSelfer"
    var facesTexture:MTLTexture?
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func specialConfig(commandEncoder:MTLComputeCommandEncoder)
    {
        let context:CIContext = CIContext()
        let options:[String:Any] = [
            CIDetectorAccuracy:CIDetectorAccuracyHigh
        ]
        
        guard
        
            let detector:CIDetector = CIDetector(
                ofType:CIDetectorTypeFace,
                context:context,
                options:options),
            let sourceTexture:MTLTexture = sourceTexture,
            let uiImage:UIImage = sourceTexture.exportImage(),
            let image:CIImage = CIImage(image:uiImage)
        
        else
        {
            return
        }
        
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:sourceTexture.pixelFormat,
            width:sourceTexture.width,
            height:sourceTexture.height,
            mipmapped:false)
        
        facesTexture = device.makeTexture(descriptor:textureDescriptor)
        
        let features:[CIFeature] = detector.features(in:image)
        
        for feature:CIFeature in features
        {
            if let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            {
                print(faceFeature.bounds)
            }
        }
        
        guard
        
            let strongFacetexture:MTLTexture = facesTexture
        
        else
        {
            return
        }
        
        commandEncoder.setTexture(strongFacetexture, at:2)
        
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
