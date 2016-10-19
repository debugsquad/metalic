import MetalPerformanceShaders
import CoreImage
import UIKit

class MetalFilterBasicSelfer:MetalFilter
{
    private var bokehSize:Int
    private var sizeRatio:Int
    private var dilate:MPSImageDilate?
    private var gaussian:MPSImageGaussianBlur?
    private let kFunctionName:String = "filter_basicSelfer"
    private let kFacesTextureIndex:Int = 2
    private let kBokehTextureIndex:Int = 3
    private let kMinImageSize:Int = 640
    private let kMinBokehSize:Int = 12
    private let kMinSizeRatio:Int = 2
    private let kRepeatingElement:Float = 1
    private let kGaussSigma:Float = 10
    
    required init(device:MTLDevice)
    {
        bokehSize = 0
        sizeRatio = kMinSizeRatio
        
        super.init(device:device, functionName:kFunctionName)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture: MTLTexture)
    {
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        
        generateDilate(sourceTexture:sourceTexture)
        generateGaussian(sourceTexture:sourceTexture)
        
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:sourceTexture.pixelFormat,
            width:sourceWidth,
            height:sourceHeight,
            mipmapped:false)
        
        let bokehTexture:MTLTexture = device.makeTexture(descriptor:textureDescriptor)
        
        dilate?.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:bokehTexture)
        gaussian?.encode(
            commandBuffer:commandBuffer,
            sourceTexture:bokehTexture,
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
        
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        let maxWidth:Int = sourceWidth - 1
        let maxHeight:Int = sourceHeight - 1
        let sourceSize:Int = sourceWidth * sourceHeight
        let sizeOfFloat:Int = MemoryLayout.size(ofValue:kRepeatingElement)
        var textureArray:[Float] = Array(
            repeating:kRepeatingElement,
            count:sourceSize)
        let bytesPerRow:Int = sizeOfFloat * sourceWidth
        let region:MTLRegion = MTLRegionMake2D(
            0,
            0,
            sourceWidth,
            sourceHeight)
        
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:MTLPixelFormat.r32Float,
            width:sourceWidth,
            height:sourceHeight,
            mipmapped:false)
        
        let facesTexture:MTLTexture = device.makeTexture(descriptor:textureDescriptor)
        let features:[CIFeature] = detector.features(in:image)
        let faceRadius:Int = bokehSize * sizeRatio
        let faceRadiusFloat:Float = Float(faceRadius)
        
        for feature:CIFeature in features
        {
            if let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            {   
                let faceFeatureX:Int = Int(faceFeature.bounds.origin.x)
                let faceFeatureW:Int = Int(faceFeature.bounds.size.width)
                let faceFeatureH:Int = Int(faceFeature.bounds.size.height)
                let faceFeatureY:Int = sourceHeight - (Int(faceFeature.bounds.origin.y) + faceFeatureH)
                let faceFeatureMaxX:Int = faceFeatureX + faceFeatureW
                let faceFeatureMaxY:Int = faceFeatureY + faceFeatureH
                let faceFeatureW_2:Int = Int(round(Float(faceFeatureW) / 2.0))
                let faceFeatureH_2:Int = Int(round(Float(faceFeatureH) / 2.0))
                let faceFeatureCenterX:Int = faceFeatureX + faceFeatureW_2
                let faceFeatureCenterY:Int = faceFeatureY + faceFeatureH_2
                let faceFeatureRadius:Int = min(faceFeatureW_2, faceFeatureH_2)
                
                var minX:Int = faceFeatureX - faceRadius
                var maxX:Int = faceFeatureMaxX + faceRadius
                var minY:Int = faceFeatureY - faceRadius
                var maxY:Int = faceFeatureMaxY + faceRadius
                
                if minX < 0
                {
                    minX = 0
                }
                
                if maxX > maxWidth
                {
                    maxX = maxWidth
                }
                
                if minY < 0
                {
                    minY = 0
                }
                
                if maxY > maxHeight
                {
                    maxY = maxHeight
                }
                
                for indexVr:Int in minY ..< maxY
                {
                    let deltaY:Int = indexVr - faceFeatureCenterY
                    let deltaY2:Int = deltaY * deltaY
                    let currentRow:Int = sourceWidth * indexVr
                    
                    for indexHr:Int in minX ..< maxX
                    {
                        let pixelIndex:Int = currentRow + indexHr
                        let currentWeight:Float = textureArray[pixelIndex]
                        
                        if currentWeight > 0
                        {
                            let deltaX:Int = indexHr - faceFeatureCenterX
                            let deltaX2:Int = deltaX * deltaX
                            let deltaSum:Int = deltaX2 + deltaY2
                            let hyp:Int = Int(sqrt(Float(deltaSum)))
                            let deltaRadius:Int = hyp - faceFeatureRadius
                            let pixelWeight:Float
                            
                            if deltaRadius > faceRadius
                            {
                                pixelWeight = 1
                            }
                            else if deltaRadius > 0
                            {
                                let deltaRadiusFloat:Float = Float(deltaRadius)
                                pixelWeight = deltaRadiusFloat / faceRadiusFloat
                            }
                            else
                            {
                                pixelWeight = 0
                            }
                            
                            if pixelWeight < currentWeight
                            {
                                textureArray[pixelIndex] = pixelWeight
                            }
                        }
                    }
                }
            }
        }
        
        let bytes:UnsafeRawPointer = UnsafeRawPointer(textureArray)
        facesTexture.replace(
            region:region,
            mipmapLevel:0,
            withBytes:bytes,
            bytesPerRow:bytesPerRow)
        
        commandEncoder.setTexture(facesTexture, at:kFacesTextureIndex)
        commandEncoder.setTexture(destinationTexture, at:kBokehTextureIndex)
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
            sizeRatio = kMinSizeRatio
        }
        else
        {
            sizeRatio = minSize / kMinImageSize
            bokehSize = kMinBokehSize * sizeRatio
        }
        
        if bokehSize % 2 == 0
        {
            bokehSize += 1
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
                
                if hypotPos < midSize
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
    
    private func generateGaussian(sourceTexture:MTLTexture)
    {
        let sourceWidth:Int = sourceTexture.width
        let sourceHeight:Int = sourceTexture.height
        let minSize:Int = min(sourceWidth, sourceHeight)
        let gaussSigma:Float
        
        if minSize <= kMinImageSize
        {
            gaussSigma = kGaussSigma
        }
        else
        {
            let gaussSizeRatio:Float = Float(minSize / kMinImageSize)
            gaussSigma = kGaussSigma * gaussSizeRatio
        }
        
        gaussian = MPSImageGaussianBlur(
            device:device,
            sigma:gaussSigma)
    }
}
