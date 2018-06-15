//
//  TextWrangler.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public enum VerticalAlignment:String
    {
    case top 
    case center
    case bottom
    }
    
public struct TextWrangler
    {
    public static func measure(string:String,usingFont font:UIFont,inWidth width:CGFloat) -> CGSize
        {
        let textStorage = NSTextStorage(string: string)
        let textContainer = NSTextContainer(size: CGSize(width:width,height:CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.count))
        textContainer.lineFragmentPadding = 0.0
        layoutManager.glyphRange(for: textContainer)
        return(layoutManager.usedRect(for: textContainer).size)
        }
        
    public static func measure(string:String,usingFont font:UIFont,inWidth width:CGFloat,alignment:NSTextAlignment,lineBreakMode:NSLineBreakMode) -> CGSize
        {
        let textStorage = NSTextStorage(string: string)
        let textContainer = NSTextContainer(size: CGSize(width:width,height:CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.count))
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        textStorage.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: string.count))
        textContainer.lineFragmentPadding = 0.0
        layoutManager.glyphRange(for: textContainer)
        return(layoutManager.usedRect(for: textContainer).size)
        }
        
    public static func string(_ string:String,centeredIn rect:CGRect,usingFont font:UIFont) -> CGPoint
        {
        let size = self.measure(string: string, usingFont: font, inWidth: 10000)
        let x = rect.origin.x + (rect.size.width - size.width) / 2.0
        let y = rect.origin.y + (rect.size.height - size.height) / 2.0
        return(CGPoint(x:x,y:y))
        }
        
    public static func position(string:String,inRect rect:CGRect,usingFont:UIFont,vertical:VerticalAlignment,horizontal:NSTextAlignment,insetBy:CGPoint) -> CGRect
        {
        let size = self.measure(string: string, usingFont: usingFont, inWidth: rect.size.width,alignment:horizontal,lineBreakMode:.byWordWrapping)
        var offset = CGPoint(x:0,y:0)
        switch(vertical)
            {
            case .top:
                offset.y = insetBy.y
            case .center:   
                offset.y = (rect.size.height - size.height) / 2.0 + insetBy.y
            case .bottom:
                offset.y = rect.maxY - size.height - insetBy.y
            }
        switch(horizontal)
            {
            case .left:
                offset.x = rect.origin.x + insetBy.x
            case .center:
                offset.x = rect.origin.x + (rect.size.width - size.width) / 2.0 + insetBy.x
            case .right:
                offset.x = rect.maxX - size.width - insetBy.x
            default:
                offset.x = insetBy.x
            }
        return(CGRect(origin:offset,size:size))
        }
    }
