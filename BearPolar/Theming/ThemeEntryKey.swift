//
//  ThemeKey.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public struct ThemeEntryKey:Hashable,ExpressibleByStringLiteral
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
        
    public var keyExcludingFirst:ThemeEntryKey
        {
        return(ThemeEntryKey(items:[String](items.dropFirst())))
        }
        
    public var keyExcludingLast:ThemeEntryKey
        {
        return(ThemeEntryKey(items:[String](items.dropLast())))
        }
        
    public var lastKey:ThemeEntryKey
        {
        return(ThemeEntryKey(items:[items[items.count-1]]))
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
        
    public init(_ string:String)
        {
        items = string.components(separatedBy: ".")
        }
        
    public init(stringLiteral string:String)
        {
        self.items = string.components(separatedBy: ".")
        }
    }
