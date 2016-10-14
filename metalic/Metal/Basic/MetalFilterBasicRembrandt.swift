import MetalPerformanceShaders

class MetalFilterBasicRembrandt:MetalFilter
{
    private let kFunctionName:String = "filter_basicRembrandt"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
