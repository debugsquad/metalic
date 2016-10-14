import MetalPerformanceShaders

class MetalFilterBasicInk:MetalFilter
{
    private let kFunctionName:String = ""
    
    override init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
