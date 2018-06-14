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
    public struct Path:Hashable,ExpressibleByStringLiteral
        {
        public typealias StringLiteralType = String
        
        private var items:[String] = []
        
        public var hashValue:Int
            {
            if items.count == 0
                {
                return(0)
                }
            var hashValue = items[0].hashValue
            for index in 1..<items.count
                {
                hashValue ^= items[index].hashValue
                }
            return(hashValue)
            }
            
        public var firstPart:String
            {
            return(items[0])
            }
            
        public var stringValue:String
            {
            return(items.joined(separator: "."))
            }
            
        public var keyExcludingFirst:ThemeItem.Path
            {
            return(ThemeItem.Path(items:[String](items.dropFirst())))
            }
            
        public var keyExcludingLast:ThemeItem.Path
            {
            return(ThemeItem.Path(items:[String](items.dropLast())))
            }
            
        public var lastKey:ThemeItem.Path
            {
            return(ThemeItem.Path(items:[items[items.count-1]]))
            }
            
        fileprivate init(items:[String])
            {
            self.items = items
            }
            
        var isEmpty:Bool
            {
            return(items.isEmpty)
            }
            
        var hasMultiple:Bool
            {
            return(items.count > 1)
            }
            
        var isSingle:Bool
            {
            return(items.count == 1)
            }
            
        var count:Int
            {
            return(items.count)
            }
            
        public init(_ key:Theme.EntryKey)
            {
            items = [key.rawValue]
            }
            
        public init(_ string:String)
            {
            items = string.components(separatedBy: ".")
            }
            
        public init(stringLiteral string:String)
            {
            self.items = string.components(separatedBy: ".")
            }
        }
    
    class func navigationBar(tint:UIColor,barTint:UIColor,titleAttributes:Theme.TextAttributes? = nil) -> ThemeItem
        {
        return(ThemeNavigationBarItem(tint:tint,barTint:barTint,titleAttributes:titleAttributes))
        }
        
    class func text(textColor:UIColor = .black,font:UIFont = UIFont.systemFont(ofSize:12),alignment:Theme.Alignment = .left,wrapped:Bool = false) -> ThemeItem
        {
        return(ThemeTextItem(textColor:textColor,font:font,alignment:alignment,wrapped:wrapped))
        }
        
    class func content(backgroundColor:UIColor = .white,contentColor:UIColor? = nil,highlightColor:UIColor? = nil,selectedColor:UIColor? = nil) -> ThemeItem
        {
        return(ThemeContentItem(backgroundColor:backgroundColor,contentColor:contentColor,highlightColor:highlightColor))
        }
        
    class func border(borderColor:UIColor = .clear,width:CGFloat = 0 ,corners:UIRectCorner? = nil,radius:CGFloat?=nil,edges:UIRectEdge? = nil) -> ThemeItem
        {
        return(ThemeBorderItem(borderColor:borderColor,width:width,corners:corners,radius:radius,edges:edges))
        }
        
    class func line(lineColor:UIColor,width:CGFloat) -> ThemeItem
        {
        return(ThemeLineItem(lineColor:lineColor,width:width))
        }
        
    subscript(_ key:ThemeItem.Path) -> ThemeItem?
        {
        get
            {
            return(self)
            }
        set(value)
            {
            }
        }
        
    func textItem(at path:ThemeItem.Path) -> ThemeTextItem
        {
        guard let item = self[path] as? ThemeTextItem else
            {
            fatalError("No item found for path \(path)")
            }
        return(item)
        }
        
    func borderItem(at path:ThemeItem.Path) -> ThemeBorderItem
        {
        guard let item = self[path] as? ThemeBorderItem else
            {
            fatalError("No item found for path \(path)")
            }
        return(item)
        }
        
    func contentItem(at path:ThemeItem.Path) -> ThemeContentItem
        {
        guard let item = self[path] as? ThemeContentItem else
            {
            fatalError("No item found for path \(path)")
            }
        return(item)
        }
        
    func apply(to view:UIView)
        {
        }
        
    func apply(to label:UILabel)
        {
        
        }
        
    func apply(to button:UIButton)
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
    

public class ThemeContainerItem:ThemeItem
    {
    private var items = ThemeItemDictionary()
        
    override subscript(_ inputKey:ThemeItem.Path) -> ThemeItem?
        {
        get
            {
            return(items[inputKey])
            }
        set
            {
            items[inputKey] = newValue
            }
        }
        
    override func apply(to object:UIView)
        {
        items.forEachValue
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CALayer)
        {
        items.forEachValue
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CATextLayer)
        {
        items.forEachValue
            {
            item in
            item.apply(to: object)
            }
        }
        
    override func apply(to object:CAShapeLayer)
        {
        items.forEachValue
            {
            item in
            item.apply(to: object)
            }
        }
    }
    
public class ThemeContentItem:ThemeItem
    {
    let backgroundColor:UIColor
    let contentColor:UIColor?
    let highlightColor:UIColor?
    
    init(backgroundColor:UIColor,contentColor:UIColor?,highlightColor:UIColor?)
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
        layer.backgroundColor = backgroundColor.cgColor
        }
        
    override func apply(to button:UIButton)
        {
        button.backgroundColor = backgroundColor
        }
    }
    
public class ThemeTextItem:ThemeItem
    {
    let textColor:UIColor
    let font:UIFont
    let alignment:Theme.Alignment
    let wrapped:Bool
    
    init(textColor:UIColor,font:UIFont,alignment:Theme.Alignment,wrapped:Bool)
        {
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
        self.wrapped = wrapped
        }
        
    override func apply(to layer:CATextLayer)
        {
        layer.foregroundColor = textColor.cgColor
        layer.font = font.fontName as CFTypeRef
        layer.fontSize = font.pointSize
        layer.alignmentMode = alignment.caTextLayerAligment
        layer.isWrapped = wrapped
        layer.setNeedsLayout()
        }
        
    override func apply(to label:UILabel)
        {
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment.nsTextAlignment
        }
        
    override func apply(to button:UIButton)
        {
        button.setTitleColor(textColor, for: .normal)
        }
    }
    
public class ThemeBorderItem:ThemeItem
    {
    let borderColor:UIColor
    let borderWidth:CGFloat
    let corners:UIRectCorner?
    let edges:UIRectEdge?
    let radius:CGFloat?
    
    init(borderColor:UIColor,width:CGFloat,corners:UIRectCorner?,radius:CGFloat?,edges:UIRectEdge?)
        {
        self.borderColor = borderColor
        self.borderWidth = width
        self.corners = corners
        self.radius = radius
        self.edges = edges
        }
        
    override func apply(to layer:CAShapeLayer)
        {
        layer.strokeColor = borderColor.cgColor
        layer.lineWidth = borderWidth
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
    let lineColor:UIColor
    let width:CGFloat
    
    init(lineColor:UIColor,width:CGFloat)
        {
        self.lineColor = lineColor
        self.width = width
        }
    }
    
