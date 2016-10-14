import MetalPerformanceShaders

class MetalFilterBasicInk:MetalFilter
{
    private let kFunctionName:String = ""
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
