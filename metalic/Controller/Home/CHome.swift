import UIKit
import Metal

class CHome:CController
{
    weak var viewHome:VHome!
    var mtlDevice:MTLDevice!
    var pipelineState: MTLRenderPipelineState! = nil
    var commandQueue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mtlDevice = MTLCreateSystemDefaultDevice()
        
        viewHome.viewPicture.viewLoaded()
        
        // 1
        let defaultLibrary = mtlDevice.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.makeFunction(name:"basic_fragment")
        let vertexProgram = defaultLibrary!.makeFunction(name:"basic_vertex")
        
        // 2
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.bgra8Unorm
        
        // 3
        do
        {
            try pipelineState = mtlDevice.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        }
        catch
        {
        }
        
        commandQueue = mtlDevice.makeCommandQueue()
        
        
        timer = CADisplayLink(target:self, selector:#selector(gameloop(sender:)))
        timer.add(to:RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func gameloop(sender timer:CADisplayLink)
    {
        autoreleasepool {
            self.render()
        }
    }
    
    func render() {
        let drawable = viewHome.viewPicture.metalLayer.nextDrawable()
        
        if drawable != nil
        {
            let renderPassDescriptor = MTLRenderPassDescriptor()
            
            renderPassDescriptor.colorAttachments[0].texture = drawable!.texture
            renderPassDescriptor.colorAttachments[0].loadAction = .clear
            renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            
            let commandBuffer = commandQueue.makeCommandBuffer()
            
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor:renderPassDescriptor)
            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.setVertexBuffer(viewHome.viewPicture.vertexBuffer, offset:0, at:0)
            renderEncoder.drawPrimitives(type: MTLPrimitiveType.triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
            renderEncoder.endEncoding()
            
            
            commandBuffer.present(drawable!)
            commandBuffer.commit()
        }
    }
    
    //MARK: public
    
    func imageSelected(image:UIImage?)
    {
        viewHome.viewPicture.imageView.image = image
    }
}
