import MetalPerformanceShaders

class MetalFilterBasicInk:MetalFilter
{
    private let kFunctionName:String = "filter_basicInk"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
