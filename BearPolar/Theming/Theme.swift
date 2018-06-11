//
//  Theme.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit


    
public class Theme
    {
    public enum Alignment
        {
        case left
        case right
        case center        
        case justified
        case natural
        
        var caTextLayerAligment:String
            {
            switch(self)
                {
            case .left:
                return(kCAAlignmentLeft)
            case .right:
                return(kCAAlignmentRight)
            case .justified:
                return(kCAAlignmentJustified)
            case .natural:
                return(kCAAlignmentNatural)
            case .center:
                return(kCAAlignmentCenter)
                }
            }
        }
        
    public enum Key:String
        {
        case null
        case pinPad
        case header
        case navigationBar
        case textEntry
        case lime
        case tangerine
        case aqua
        }
    
    public typealias TextAttributes = [NSAttributedStringKey:Any]
    
    public private(set) var key:Key
    
    internal var items:[String:ThemeItem] = [:]
    
    public init(_ key:Key)
        {
        self.key = key
        }
        
    init()
        {
        self.key = .null
        }
        
    subscript(_ inputKey:ThemeEntryKey) -> ThemeItem?
        {
        get
            {
            guard let value = items[inputKey.firstPart] else
                {
                return(nil)
                }
            if inputKey.isSingle
                {
                return(value)
                }
            return(value[inputKey.keyExcludingFirst])
            }
        set
            {
            if inputKey.hasMultiple
                {
                guard let theme = items[inputKey.firstPart] else
                    {
                    fatalError("Trying to set value in something not a theme")
                    }
                theme[inputKey.keyExcludingFirst] = newValue
                }
            else
                {
                items[inputKey.stringValue] = newValue
                }
            }
        }
        
    func forItems(closure: (ThemeItem) -> ())
        {
        for value in items.values
            {
            closure(value)
            }
        }
    }
