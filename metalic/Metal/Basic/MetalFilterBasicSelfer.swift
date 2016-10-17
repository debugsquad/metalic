import MetalPerformanceShaders

class MetalFilterBasicSelfer:MetalFilter
{
    private let kFunctionName:String = "filter_basicSelfer"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
