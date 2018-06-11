//
//  ThemeItem.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit
    
public class ThemeItem
    {
    class func navigationBar(tint:UIColor,barTint:UIColor,titleAttributes:Theme.TextAttributes? = nil) -> ThemeItem
        {
        return(ThemeNavigationBarItem(tint:tint,barTint:barTint,titleAttributes:titleAttributes))
        }
        
    class func text(textColor:UIColor? = nil,font:UIFont? = nil,alignment:Theme.Alignment? = nil) -> ThemeItem
        {
        return(ThemeTextItem(textColor:textColor,font:font,alignment:alignment))
        }
        
    class func content(backgroundColor:UIColor? = nil,contentColor:UIColor? = nil,highlightColor:UIColor? = nil,selectedColor:UIColor? = nil) -> ThemeItem
        {
        return(ThemeContentItem(backgroundColor:backgroundColor,contentColor:contentColor,highlightColor:highlightColor))
        }
        
    class func border(borderColor:UIColor?,width:CGFloat?=nil,corners:UIRectCorner? = nil,radius:CGFloat?=nil,edges:UIRectEdge? = nil) -> ThemeItem
        {
        return(ThemeBorderItem(borderColor:borderColor,width:width,corners:corners,radius:radius,edges:edges))
        }
        
    class func line(lineColor:UIColor?,width:CGFloat? = nil) -> ThemeItem
        {
        return(ThemeLineItem(lineColor:lineColor,width:width))
        }
        
    class func childTheme() -> ThemeItem
        {
        return(ThemeChildItem(theme:Theme()))
        }
        
    subscript(_ key:ThemeEntryKey) -> ThemeItem?
        {
        get
            {
            return(self)
            }
        set(value)
            {
            }
        }
        
    func apply(to view:UIView)
        {
        }
        
    func apply(to layer:CALayer)
        {
        }
        
    func apply(to layer:CATextLayer)
        {
        }

    func apply(to layer:CAShapeLayer)
        {
        }
        
    func apply(to layers:[CATextLayer])
        {
        for layer in layers
            {
            apply(to: layer)
            }
        }
        
    func apply(to layers:[CALayer])
        {
        for layer in layers
            {
            apply(to: layer)
            }
        }
        
    func apply(to layers:[CAShapeLayer])
        {
        for layer in layers
            {
            apply(to: layer)
            }
        }
        
    func apply(to bar:UINavigationBar)
        {
        }
    }
    
public class ThemeNullItem:ThemeItem
    {
    static var shared:ThemeItem = ThemeNullItem()
    }
    
public class ThemeNavigationBarItem:ThemeItem
    {
    let tint:UIColor?
    let barTint:UIColor?
    let titleAttributes:Theme.TextAttributes?
    
    init(tint:UIColor?,barTint:UIColor?,titleAttributes:Theme.TextAttributes?)
        {
        self.tint = tint
        self.barTint = barTint
        self.titleAttributes = titleAttributes
        }
        
    override func apply(to bar:UINavigationBar)
        {
        bar.tintColor = tint
        bar.barTintColor = barTint
        bar.titleTextAttributes = titleAttributes
        }
    }
    

public class ThemeChildItem:ThemeItem
    {
    let theme:Theme
    
    init(theme:Theme)
        {
        self.theme = theme
        }
        
    override subscript(_ inputKey:ThemeEntryKey) -> ThemeItem?
        {
        get
            {
            return(theme[inputKey])
            }
        set
            {
            theme[inputKey] = newValue
            }
        }
        
    override func apply(to object:UIView)
        {
        theme.forItems
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CALayer)
        {
        theme.forItems
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CATextLayer)
        {
        theme.forItems
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CAShapeLayer)
        {
        theme.forItems
            {
            item in
            item.apply(to: object)
            }
        }
    }
    
public class ThemeContentItem:ThemeItem
    {
    let backgroundColor:UIColor?
    let contentColor:UIColor?
    let highlightColor:UIColor?
    
    init(backgroundColor:UIColor?,contentColor:UIColor?,highlightColor:UIColor?)
        {
        self.backgroundColor = backgroundColor
        self.contentColor = contentColor
        self.highlightColor = highlightColor
        }
        
    override func apply(to view:UIView)
        {
        view.backgroundColor = backgroundColor
        }
        
    override func apply(to layer:CALayer)
        {
        layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
public class ThemeTextItem:ThemeItem
    {
    let textColor:UIColor?
    let font:UIFont?
    let alignment:Theme.Alignment?
    
    init(textColor:UIColor?,font:UIFont?,alignment:Theme.Alignment?)
        {
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
        }
        
    override func apply(to layer:CATextLayer)
        {
        layer.foregroundColor = textColor?.cgColor
        if let aFont = font
            {
            layer.font = aFont.fontName as CFTypeRef
            layer.fontSize = aFont.pointSize
            }
        if let anAlignment = alignment 
            {
            layer.alignmentMode = anAlignment.caTextLayerAligment
            }
        layer.setNeedsLayout()
        }
    }
    
public class ThemeBorderItem:ThemeItem
    {
    let borderColor:UIColor?
    let width:CGFloat?
    let corners:UIRectCorner?
    let edges:UIRectEdge?
    let radius:CGFloat?
    
    init(borderColor:UIColor?,width:CGFloat?,corners:UIRectCorner?,radius:CGFloat?,edges:UIRectEdge?)
        {
        self.borderColor = borderColor
        self.width = width
        self.corners = corners
        self.radius = radius
        self.edges = edges
        }
        
    override func apply(to layer:CAShapeLayer)
        {
        layer.strokeColor = borderColor?.cgColor
        if let lineWidth = width
            {
            layer.lineWidth = lineWidth
            }
        }
        
    override func apply(to layers:[CAShapeLayer])
        {
        for layer in layers
            {
            self.apply(to: layer)
            }
        }
    }
    
public class ThemeLineItem:ThemeItem
    {
    let lineColor:UIColor?
    let width:CGFloat?
    
    init(lineColor:UIColor?,width:CGFloat?)
        {
        self.lineColor = lineColor
        self.width = width
        }
    }
    
