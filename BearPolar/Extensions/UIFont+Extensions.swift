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
        case heavy = "Heavy"
        case bold = "Bold"
        case semiBold = "Semibold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        }
        
    static func applicationFont(weight weight:FontWeight,size size:CGFloat) -> UIFont
        {
        let name = "SFProText-\(weight.rawValue)"
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
