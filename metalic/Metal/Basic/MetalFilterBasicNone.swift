import MetalPerformanceShaders

class MetalFilterBasicNone:MetalFilter
{
    private let kFunctionName:String = "filter_basicNone"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
