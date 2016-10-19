import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private var bokehSize:Int
    private var dilate:MPSImageDilate?
    private let kFunctionName:String = "filter_basicSelfer"
    private let kFacesTextureIndex:Int = 2
    private let kMinImageSize:Int = 640
    private let kMinBokehSize:Int = 15
    
    required init(device:MTLDevice)
    {
        bokehSize = 0
        
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture: MTLTexture)
    {
        generateDilate(sourceTexture:sourceTexture)
        
        dilate.encode(commandBuffer:commandBuffer,
                      sourceTexture:sourceTexture,
                      destinationTexture:destinationTexture)
        
        super.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
        
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
            pixelFormat:MTLPixelFormat.r32Float,
            width:sourceTexture.width,
            height:sourceTexture.height,
            mipmapped:false)
        
        let facesTexture:MTLTexture = device.makeTexture(descriptor:textureDescriptor)
        let features:[CIFeature] = detector.features(in:image)
        let sizeOfFloat:Int = MemoryLayout.size(ofValue:kRepeatingValue)
        let sourceHeight:Int = sourceTexture.height
        
        for feature:CIFeature in features
        {
            if let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            {   
                let faceFeatureX:Int = Int(faceFeature.bounds.origin.x)
                let faceFeatureW:Int = Int(faceFeature.bounds.size.width)
                let faceFeatureH:Int = Int(faceFeature.bounds.size.height)
                let faceFeatureY:Int = sourceHeight - (Int(faceFeature.bounds.origin.y) + faceFeatureH)
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
        commandEncoder.setTexture(destinationTexture, at:3)
    }
    
    //MARK: private
    
    private func generateDilate(sourceTexture:MTLTexture)
    {
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        let minSize:Int = min(sourceWidth, sourceHeight)
        
        if minSize <= kMinImageSize
        {
            bokehSize = kMinBokehSize
        }
        else
        {
            let sizeRatio:Int = minSize / kMinImageSize
            bokehSize = kMinBokehSize * sizeRatio
        }
        
        var probe:[Float] = []
        let bokehSizeFloat:Float = Float(bokehSize)
        let midSize:Float = bokehSizeFloat / 2.0
        
        for indexHr:Int in 0 ..< bokehSize
        {
            let indexHrFloat:Float = Float(indexHr)
            let xPos:Float = abs(indexHrFloat - midSize)
            
            for indexVr:Int in 0 ..< bokehSize
            {
                let indexVrFloat:Float = Float(indexVr)
                let yPos:Float = abs(indexVrFloat - midSize)
                let hypotPos:Float = hypot(xPos, yPos)
                let probeElement:Float
                
                if hypotPos > bokehSizeFloat
                {
                    probeElement = 0
                }
                else
                {
                    probeElement = 1
                }
                
                probe.append(probeElement)
            }
        }
        
        dilate = MPSImageDilate(
            device:device,
            kernelWidth:bokehSize,
            kernelHeight:bokehSize,
            values:probe)
    }
}
