import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private let kFunctionName:String = "filter_basicSelfer"
    private let kRepeatingValue:Float = 1
    private let kFacesTextureIndex:Int = 2
    
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
        
        let facesTexture:MTLTexture = device.makeTexture(descriptor:textureDescriptor)
        let sizeOfFloat:Int = MemoryLayout.size(ofValue:Float())
        let features:[CIFeature] = detector.features(in:image)
        
        for feature:CIFeature in features
        {
            if let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            {
                let faceFeatureX:Int = Int(faceFeature.bounds.minX)
                let faceFeatureY:Int = Int(faceFeature.bounds.minY)
                let faceFeatureW:Int = Int(faceFeature.bounds.maxX)
                let faceFeatureH:Int = Int(faceFeature.bounds.maxY)
                let regionSize:Int = faceFeatureW * faceFeatureH
                let bytesPerRow:Int = sizeOfFloat * faceFeatureW
                let region:MTLRegion = MTLRegionMake2D(
                    faceFeatureX,
                    faceFeatureY,
                    faceFeatureW,
                    faceFeatureH)
                let floatArray:[Float] = Array(
                    repeating:kRepeatingValue,
                    count:regionSize)
                let bytes:UnsafeRawPointer = UnsafeRawPointer(floatArray)
                facesTexture.replace(
                    region:region,
                    mipmapLevel:0,
                    withBytes:bytes,
                    bytesPerRow:bytesPerRow)
            }
        }
        
        commandEncoder.setTexture(facesTexture, at:kFacesTextureIndex)
    }
}
