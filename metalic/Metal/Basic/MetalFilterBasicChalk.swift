import MetalPerformanceShaders

class MetalFilterBasicChalk:MetalFilter
{
    private let kFunctionName:String = "filter_basicChalk"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
