//
//  LayoutFrame.swift
//  Leaves
//
//  Created by Vincent Coetzee on 2018/06/04.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class LayoutFrame:NSObject
    {
    public static let zero = LayoutFrame(left:.zero,top:.zero,right:.zero,bottom:.zero)
    public static let one = LayoutFrame(left:.zero,top:.zero,right:.one,bottom:.one)
    
    public struct Edge   
        {
        let fraction:CGFloat
        let offset:CGFloat
        
        public static let zero = Edge(fraction:0,offset:0)
        public static let one = Edge(fraction:1,offset:0)
        
        init(fraction:CGFloat,offset:CGFloat)
            {
            self.fraction = fraction
            self.offset = offset
            }
            
        init(fraction:Int,offset:Int)
            {
            self.fraction = CGFloat(fraction)
            self.offset = CGFloat(offset)
            }
            
        init(fraction:CGFloat)
            {
            self.fraction = fraction
            self.offset = 0
            }
    }
    
    let left:Edge
    let top:Edge
    let right:Edge
    let bottom:Edge
    
    init(left:Edge,top:Edge,right:Edge,bottom:Edge)
        {
        self.left = left
        self.top = top
        self.bottom = bottom
        self.right = right
        super.init()
        }
        
    init(left:Edge,top:Edge)
        {
        self.left = left
        self.top = top
        self.bottom = .zero
        self.right = .zero
        }
        
    convenience init(origin:CGPoint,size:CGSize)
        {
        self.init(left:Edge(fraction:0,offset:origin.x),top: Edge(fraction:0,offset:origin.y),right: Edge(fraction:0,offset:origin.x + size.width),bottom: Edge(fraction:0,offset:origin.y + size.height))
        }
        
    convenience init(x:Int,y:Int,width:Int,height:Int)
        {
        self.init(left:Edge(fraction:0,offset:x),top: Edge(fraction:0,offset:y),right: Edge(fraction:0,offset:x + width),bottom: Edge(fraction:0,offset:y + height))
        }
        
    convenience init(leftFraction:CGFloat,topFraction:CGFloat,rightFraction:CGFloat,bottomFraction:CGFloat)
        {
        self.init(left:Edge(fraction:leftFraction),top:Edge(fraction:topFraction),right:Edge(fraction:rightFraction),bottom:Edge(fraction:bottomFraction))
        }
        
    convenience init(left:CGFloat,offset leftOffset:CGFloat,top:CGFloat,offset topOffset:CGFloat,right:CGFloat,offset rightOffset:CGFloat,bottom:CGFloat,offset bottomOffset:CGFloat)
        {
        self.init(left:Edge(fraction:left,offset:leftOffset),top:Edge(fraction:top,offset:topOffset),right:Edge(fraction:right,offset:rightOffset),bottom:Edge(fraction:bottom,offset:bottomOffset))
        }
        
    func rectIn(rect:CGRect) -> CGRect
        {
        var originX:CGFloat
        var originY:CGFloat
        var extentX:CGFloat
        var extentY:CGFloat
        
        originX = rect.minX*left.fraction + left.offset
        originY = rect.minY*top.fraction + top.offset
        extentX = rect.maxX*right.fraction + right.offset
        extentY = rect.maxY*bottom.fraction + bottom.offset
        return(CGRect(x:originX,y:originY,width:extentX-originX,height:extentY-originY))
        }
    }
