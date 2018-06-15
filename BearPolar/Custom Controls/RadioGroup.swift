//
//  RadioGroup.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/15.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public protocol Selectable
    {
    var radioGroup:RadioGroup? { get set }
    var isSelected:Bool { get }
    func select()
    func deselect()
    func apply(themeItem:ThemeItem)
    }
    
public class RadioGroup:NSObject
    {
    private var views:[Selectable] = []
    private var currentSelection:Selectable?
    
    public var onChange: (Selectable?) -> () = { value in }
        
    func add(selectable:Selectable)
        {
        views.append(selectable)
        var mutableSelectable = selectable
        mutableSelectable.radioGroup = self
        }
        
    func select(_ selectable:Selectable?)
        {
        currentSelection?.deselect()
        currentSelection = selectable
        currentSelection?.select()
        onChange(currentSelection)
        }
    }
