import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private let dilate:MPSImageDilate
    private let bokehRadius:Int = 10
    private let kFunctionName:String = "filter_basicSelfer"
    private let kRepeatingValue:Float = 0.8
    private let kFacesTextureIndex:Int = 2
    
    required init(device:MTLDevice)
    {
        var probe = [Float]()
        let size = bokehRadius * 2 + 1
        let mid = Float(size) / 2
        
        for i in 0 ..< size
        {
            for j in 0 ..< size
            {
                let x = abs(Float(i) - mid)
                let y = abs(Float(j) - mid)
                let element: Float = hypot(x, y) < Float(self.bokehRadius) ? 0.0 : 1.0
                probe.append(element)
            }
        }
        
        dilate = MPSImageDilate(
            device: device,
            kernelWidth: size,
            kernelHeight: size,
            values: probe)
        
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func encode(commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture) {
        
        dilate.encode(commandBuffer: commandBuffer,
                      sourceTexture: sourceTexture,
                      destinationTexture: destinationTexture)
        
        super.encode(commandBuffer:commandBuffer, sourceTexture:sourceTexture, destinationTexture:destinationTexture)
        
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
}
