//
//  CATextLayer+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CATextLayer
    {
    var uiFont:UIFont
        {
        return(UIFont(name: self.font as! String,size:self.fontSize)!)
        }
        
        
    public func setUIFont(_ newFont:UIFont)
        {
        self.font = newFont.fontName as CFTypeRef
        self.fontSize = newFont.pointSize
        }
        
        
    var textAttributes:[NSAttributedStringKey:Any]
        {
        return([.font: self.uiFont,.foregroundColor: UIColor(cgColor: self.foregroundColor!)])
        }
        
    func measureText(inWidth:CGFloat) -> CGRect
        {
        let text = self.string as! NSString
        let attributes = self.textAttributes
        let bounds = text.boundingRect(with: CGSize(width:inWidth,height:10000), options: [.usesLineFragmentOrigin], attributes: attributes, context: nil)
        return(bounds)
        }
    }
