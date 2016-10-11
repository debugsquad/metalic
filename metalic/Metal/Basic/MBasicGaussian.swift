//
//  MBasicGaussian.swift
//  metalic
//
//  Created by zero on 10/11/16.
//  Copyright © 2016 iturbide. All rights reserved.
//

import Foundation
import MetalPerformanceShaders

class GaussianBlur: CommandBufferEncodable {
    let gaussian: MPSImageGaussianBlur
    
    required init(device: MTLDevice) {
        gaussian = MPSImageGaussianBlur(device: device,
                                        sigma: 10.0)
    }
    
    func encode(to commandBuffer: MTLCommandBuffer, sourceTexture: MTLTexture, destinationTexture: MTLTexture) {
        gaussian.encode(commandBuffer: commandBuffer,
                        sourceTexture: sourceTexture,
                        destinationTexture: destinationTexture)
    }
}

protocol CommandBufferEncodable {
    init(device: MTLDevice)
    
    func encode(to commandBuffer: MTLCommandBuffer,
                sourceTexture: MTLTexture,
                destinationTexture: MTLTexture)
}
