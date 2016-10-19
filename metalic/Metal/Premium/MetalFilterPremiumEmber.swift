import MetalPerformanceShaders

class MetalFilterPremiumEmber:MetalFilter
{
    private var histogramInfo:MPSImageHistogramInfo
    private let histogramOptions:MTLResourceOptions
    private let calculation:MPSImageHistogram
    private let equalization:MPSImageHistogramEqualization
    private let kHistogramEntries:Int = 256
    private let kAlphaChannel:ObjCBool = false
    private let kMinPixelValue:Float = 0
    private let kMaxCyanPixelValue:Float = 0.35
    private let kMaxMagentaPixelValue:Float = 0.45
    private let kMaxYellowPixelValue:Float = 0.5
    private let kMaxKeyPixelValue:Float = 1
    private let kHistogramOffset:Int = 0
    
    required init(device:MTLDevice)
    {
        let minPixel:vector_float4 = vector_float4(
            kMinPixelValue,
            kMinPixelValue,
            kMinPixelValue,
            1
        )
        
        let maxPixel:vector_float4 = vector_float4(
            kMaxCyanPixelValue,
            kMaxMagentaPixelValue,
            kMaxYellowPixelValue,
            kMaxKeyPixelValue
        )
        
        histogramInfo = MPSImageHistogramInfo(
            numberOfHistogramEntries:kHistogramEntries,
            histogramForAlpha:kAlphaChannel,
            minPixelValue:minPixel,
            maxPixelValue:maxPixel)
        
        histogramOptions = MTLResourceOptions([
            MTLResourceOptions.storageModePrivate
            ])
        
        calculation = MPSImageHistogram(
            device:device,
            histogramInfo:&histogramInfo)
        
        equalization = MPSImageHistogramEqualization(
            device:device,
            histogramInfo:&histogramInfo)
        
        super.init(device:device, functionName:nil)
    }
    
    override func encode(commandBuffer:MTLCommandBuffer, sourceTexture:MTLTexture, destinationTexture:MTLTexture)
    {
        let pixelFormat:MTLPixelFormat = sourceTexture.pixelFormat
        let histogramSize:Int = calculation.histogramSize(
            forSourceFormat:pixelFormat)
        let histogramBuffer:MTLBuffer = device.makeBuffer(
            length:histogramSize,
            options:histogramOptions)
        
        calculation.encode(
            to:commandBuffer,
            sourceTexture:sourceTexture,
            histogram:histogramBuffer,
            histogramOffset:kHistogramOffset)
        
        equalization.encodeTransform(
            to:commandBuffer,
            sourceTexture:sourceTexture,
            histogram:histogramBuffer,
            histogramOffset:kHistogramOffset)
        
        equalization.encode(
            commandBuffer:commandBuffer,
            sourceTexture:sourceTexture,
            destinationTexture:destinationTexture)
    }
}
