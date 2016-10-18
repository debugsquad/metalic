import MetalPerformanceShaders

class MetalFilterBasicComic:MetalFilter
{
    private let kFunctionName:String = "filter_basicComic"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
