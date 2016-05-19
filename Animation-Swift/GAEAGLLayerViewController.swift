//
//  GAEAGLLayerViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/18.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit
import GLKit
import QuartzCore

class GAEAGLLayerViewController: UIViewController {
    
    var frameBuffer         : GLuint = 0
    var colorRenderbuffer   : GLuint = 0
    var framebufferWidth    : GLint  = 0
    var framebufferHeight   : GLint  = 0
    
    lazy var glContext:EAGLContext = {
        let context = EAGLContext.init(API: EAGLRenderingAPI.OpenGLES2)
        return context
    }()
    
    lazy var glLayer: CAEAGLLayer = {
        let layer = CAEAGLLayer()
        layer.frame = self.view.bounds
        layer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking: false,
                                    kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8]
        return layer
    }()
    
    lazy var effect: GLKBaseEffect = {
        let effect = GLKBaseEffect()
        return effect
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //context
        EAGLContext.setCurrentContext(glContext)
        
        //layer
        self.view.layer.addSublayer(glLayer)
        
        //set up buffers
        setupBuffers()
        
        //draw frame
        drawFrame()
    }
    
    deinit {
        tearDownBuffers()
        EAGLContext.setCurrentContext(nil)
    }
    
    func setupBuffers() -> Void {
        //set up frame buffer
        glGenFramebuffers(1, &frameBuffer)
        glBindFramebuffer(GL_FRAMEBUFFER.UIntValue(), frameBuffer)
        
        //set up color render buffer
        glGenRenderbuffers(1, &colorRenderbuffer)
        glBindRenderbuffer(GL_RENDERBUFFER.UIntValue(), colorRenderbuffer)
        glFramebufferRenderbuffer(GL_FRAMEBUFFER.UIntValue(), GL_COLOR_ATTACHMENT0.UIntValue(), GL_RENDERBUFFER.UIntValue(), colorRenderbuffer)
        glContext.renderbufferStorage(GL_RENDERBUFFER.IntValue(), fromDrawable: glLayer)
        glGetRenderbufferParameteriv(GL_RENDERBUFFER.UIntValue(), GL_RENDERBUFFER_WIDTH.UIntValue(), &framebufferWidth)
        glGetRenderbufferParameteriv(GL_RENDERBUFFER.UIntValue(), GL_RENDERBUFFER_HEIGHT.UIntValue(), &framebufferHeight)
        
        //check success
        print(glCheckFramebufferStatus(GL_FRAMEBUFFER.UIntValue()))
        print(GL_FRAMEBUFFER_COMPLETE)
        if Int32(glCheckFramebufferStatus(GL_FRAMEBUFFER.UIntValue())) != GL_FRAMEBUFFER_COMPLETE {
            print("Failed to make complete framebuffer object")
        }
    }
    
    func tearDownBuffers() {
        if frameBuffer != 0 {
            glDeleteFramebuffers(1, &frameBuffer)
            frameBuffer = 0
        }
        
        if colorRenderbuffer != 0 {
            glDeleteRenderbuffers(1, &colorRenderbuffer)
            colorRenderbuffer = 0
        }
    }
    
    func drawFrame() {
        //bind framebuffer & set viewport
        glBindFramebuffer(GL_FRAMEBUFFER.UIntValue(), frameBuffer)
        glViewport(0, 0, framebufferWidth, framebufferHeight)
        
        //bind shader program
        effect.prepareToDraw()
        
        //clear the screen
        glClear(GL_COLOR_BUFFER_BIT.UIntValue())
        glClearColor(0.0, 0.0, 0.0, 1.0)
        
        //set up vertices
        let vertics: [GLfloat] = [-0.5, -0.5, -1.0, 0.0, 0.5, -1.0, 0.5, -0.5, -1.0]
        
        ///set up colors
        let colors: [GLfloat] = [0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0]
        
        //draw triangle
        glEnableVertexAttribArray(GLKVertexAttrib.Position.rawValue.UIntValue())
        glEnableVertexAttribArray(GLKVertexAttrib.Color.rawValue.UIntValue())
        glVertexAttribPointer(GLKVertexAttrib.Position.rawValue.UIntValue(), 3, GL_FLOAT.UIntValue(), UInt8(GL_FALSE), 0, vertics)
        glVertexAttribPointer(GLKVertexAttrib.Color.rawValue.UIntValue(), 4, GL_FLOAT.UIntValue(), UInt8(GL_FALSE), 0, colors)
        glDrawArrays(GL_TRIANGLES.UIntValue(), 0, 3)
        
        //present render buffer
        glBindRenderbuffer(GL_RENDERBUFFER.UIntValue(), colorRenderbuffer)
        glContext.presentRenderbuffer(GL_RENDERBUFFER.IntValue())
    }
}

extension Int32 {
    func UIntValue() -> UInt32 {
        return UInt32(self)
    }
    
    func IntValue() -> Int {
        return Int(self)
    }
}
