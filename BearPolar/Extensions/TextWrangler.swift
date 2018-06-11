//
//  TextWrangler.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

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
    }
