//
//  UIFont+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension UIFont
    {
    public enum FontWeight:String
        {
        case weight100 = "100"
        case weight300 = "300"
        case weight500 = "500"
        case weight700 = "700"
        case weight900 = "900"
        }
        
    static func applicationFont(weight weight:FontWeight,size size:CGFloat) -> UIFont
        {
        let name = "MuseoSans-\(weight.rawValue)"
        return(UIFont(name: name,size: size)!)
        }
        
    func size(of text:String,inColor:UIColor) -> CGSize
        {
        return(text.size(withAttributes: [.font: self,.foregroundColor: inColor]))
        }
        
    static func attributesWithFont(weight:FontWeight,size:CGFloat,color:UIColor? = nil) -> [NSAttributedStringKey:Any]
        {
        let font = self.applicationFont(weight:weight,size:size)
        return([.font:font,.foregroundColor:color ?? UIColor.black])
        }
    }
