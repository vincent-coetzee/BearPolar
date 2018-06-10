//
//  CGPoint+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGPoint
    {
    public static func -(lhs:CGPoint,delta:CGFloat) -> CGPoint
        {
        return(CGPoint(x:lhs.x - delta,y:lhs.y - delta))
        }
    public static func +(lhs:CGPoint,rhs:CGPoint) -> CGPoint
        {
        return(CGPoint(x:lhs.x + rhs.x,y:lhs.y + rhs.y))
        }
    }
