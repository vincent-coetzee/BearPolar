//
//  File.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/13.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public struct ThemeItemDictionary
    {
    private var items:[String:ThemeItem] = [:]
    
    subscript(_ inputKey:ThemeItem.Path) -> ThemeItem?
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
                let firstPart = inputKey.firstPart
                guard let item = items[firstPart] else
                    {
                    let item = ThemeContainerItem()
                    items[firstPart] = item
                    item[inputKey.keyExcludingFirst] = newValue
                    return
                    }
                item[inputKey.keyExcludingFirst] = newValue
                }
            else
                {
                items[inputKey.stringValue] = newValue
                }
            }
        }
        
    public func forEachValue(closure: (ThemeItem) -> ())
        {
        items.values.forEach
            {
            item in
            closure(item)
            }
        }
    }
