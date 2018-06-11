//
//  CGSize+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGSize
    {
    static func *(lhs:CGSize,rhs:CGPoint) -> CGSize
        {
        return(CGSize(width:lhs.width*rhs.x,height:lhs.height*rhs.y))
        }
        
    static func /(lhs:CGSize,rhs:CGFloat) -> CGSize
        {
        return(CGSize(width:lhs.width/rhs,height:lhs.height/rhs))
        }
        
    static func *(lhs:CGSize,rhs:CGFloat) -> CGSize
        {
        return(CGSize(width:lhs.width*rhs,height:lhs.height*rhs))
        }
        
    var centerPoint:CGPoint
        {
        return(CGPoint(x:width/2.0,y:height/2.0))
        }
        
    func centeredRectInRect(_ rect:CGRect) -> CGRect
        {
        let deltaY = floor((rect.height - self.height)/2.0)
        let deltaX = floor((rect.width - self.width)/2.0)
        return(CGRect(origin:rect.origin + CGPoint(x:deltaX,y:deltaY),size:self))
        }
        
    func maximum(of:CGSize) -> CGSize
        {
        return(CGSize(width:max(self.width,of.width),height:max(self.height,of.height)))
        }
    }
