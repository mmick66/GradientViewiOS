//
//  GradientView.swift
//  GradientView
//
//  Created by Michael Michailidis on 23/07/2015.
//  Copyright © 2015 karmadust. All rights reserved.
//

import UIKit


class GradientView: UIView {

    var lastElementIndex: Int = 0
    var colors: Array<UIColor> = [] {
        didSet {
            lastElementIndex = colors.count - 1
        }
    }
    
    var index: Int = 0
    
    var factor: CGFloat = 1.0
    
    
    lazy var displayLink : CADisplayLink = {
        let displayLink : CADisplayLink = CADisplayLink(target: self, selector: "screenUpdated:")
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink.paused = true
        return displayLink
    }()
    
    
    func animateToNextGradient() {
        
        index = (index + 1) % colors.count
        
        self.setNeedsDisplay()
        
        self.factor = 0.0
        
        self.displayLink.paused = false
        
        
    }
    
    var frameTimestamp : Double = 0.0
    
    func screenUpdated(displayLink : CADisplayLink) {
        let currentTime = self.displayLink.timestamp
        let renderTime = currentTime - frameTimestamp;
        
        self.factor += 0.02
        
        if(self.factor > 1.0) {
            self.displayLink.paused = true
        }
        
        self.setNeedsDisplay()
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        if colors.count < 2 {
            return;
        }
        
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        
        let c1 = colors[index == 0 ? lastElementIndex : index - 1]    // => previous color from index
        let c2 = colors[index]                                        // => current color
        let c3 = colors[index == lastElementIndex ? 0 : index + 1]    // => next color
        
        var c1Comp = CGColorGetComponents(c1.CGColor)
        var c2Comp = CGColorGetComponents(c2.CGColor)
        var c3Comp = CGColorGetComponents(c3.CGColor)
        

        var colorComponents = [
            
            c1Comp[0] * (1 - factor) + c2Comp[0] * factor,
            c1Comp[1] * (1 - factor) + c2Comp[1] * factor,
            c1Comp[2] * (1 - factor) + c2Comp[2] * factor,
            c1Comp[3] * (1 - factor) + c2Comp[3] * factor,
            
            c2Comp[0] * (1 - factor) + c3Comp[0] * factor,
            c2Comp[1] * (1 - factor) + c3Comp[1] * factor,
            c2Comp[2] * (1 - factor) + c3Comp[2] * factor,
            c2Comp[3] * (1 - factor) + c3Comp[3] * factor
            
        ]
        
        
        let gradient = CGGradientCreateWithColorComponents(
            CGColorSpaceCreateDeviceRGB(),
            &colorComponents,
            [0.0, 1.0],
            2
        )
        
        
        CGContextDrawLinearGradient(
            context,
            gradient,
            CGPoint(x: 0.0, y: 0.0),
            CGPoint(x: rect.size.width, y: rect.size.height),
            0
        )
        
        CGContextRestoreGState(context);

    }

}



