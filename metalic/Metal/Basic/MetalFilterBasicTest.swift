import MetalPerformanceShaders

class MetalFilterBasicTest:MetalFilter
{
    private let kFunctionName:String = "filter_basicTest"
    
    required init(device:MTLDevice)
    {
        super.init(device:device, functionName:kFunctionName)
    }
}
