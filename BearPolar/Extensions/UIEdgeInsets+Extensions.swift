//
//  UIEdgeInsets+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/14.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension UIEdgeInsets
    {
    public var totalHorizontalInset:CGFloat
        {
        return(left + right)
        }
        
    public var totalVerticallInset:CGFloat
        {
        return(top + bottom)
        }
    }
