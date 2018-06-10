//
//  CGRect+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGRect
    {
    public var centerPoint:CGPoint
        {
        return(CGPoint(x:self.midX,y:self.midY))
        }
        
    public var topLeft:CGPoint
        {
        return(CGPoint(x:self.minX,y:self.minY))
        }
        
    public var topRight:CGPoint
        {
        return(CGPoint(x:self.maxX,y:self.minY))
        }
        
    public var bottomLeft:CGPoint
        {
        return(CGPoint(x:self.minX,y:self.maxY))
        }
        
    public var bottomRight:CGPoint
        {
        return(CGPoint(x:self.maxX,y:self.maxY))
        }
        
    public func offsetOfCenteredText(text:String,withFont:UIFont) -> CGPoint
        {
        let attributes:[NSAttributedStringKey:Any] = [.font:withFont]
        let size = (text as NSString).size(withAttributes: attributes)
        let deltaY = floor((self.height - size.height)/2.0)
        let deltaX = floor((self.width - size.width)/2.0)
        return(origin + CGPoint(x:deltaX,y:deltaY))
        }
    }
