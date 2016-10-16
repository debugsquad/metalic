import MetalPerformanceShaders

class MetalFilterBasicGothic:MetalFilter
{
    private let kFunctionName:String = "filter_basicGothic"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
