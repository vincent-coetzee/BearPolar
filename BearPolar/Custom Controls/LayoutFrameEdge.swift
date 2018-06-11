//
//  LayoutFrameEdge.swift
//  Leaves
//
//  Created by Vincent Coetzee on 2018/06/04.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public struct LayoutFrameEdge   
    {
    let fraction:CGFloat
    let offset:CGFloat
    
    public static let zero = LayoutFrameEdge(fraction:0,offset:0)
    public static let one = LayoutFrameEdge(fraction:1,offset:0)
    
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
