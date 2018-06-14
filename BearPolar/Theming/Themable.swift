//
//  Stylable.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public protocol Themable
    {
    var themeItem:ThemeItem? { get }
    var themeEntryKey:Theme.EntryKey? { get }
    var themeEntryName:String? { get set }
    func applyTheming()
    func apply(themeItem:ThemeItem)
    }
    
fileprivate var KeyForPath = "__KEY_FOR_THEME_PATH__"

extension Themable where Self:UIView
    {        
    public var themeEntryKey:Theme.EntryKey?
        {
        guard let name = self.themeEntryName else
            {
            return(nil)
            }
        return(Theme.EntryKey(rawValue:name))
        }
        
    public var themeEntryName:String?
        {
        get
            {
            return(self.associatedObject(for: &KeyForPath) as? String)
            }
        set(newName)
            {
            self.setAssociatedObject(newName as Any,for: &KeyForPath)
            (self as Themable).applyTheming()
            }
        }
        
    public var themeItem:ThemeItem?
        {
        guard let path = self.themeEntryKey else
            {
            return(nil)
            }
        return(Theme.shared[path])
        }
        
    public func applyTheming()
        {
        if let themeItem = self.themeItem
            {
            self.apply(themeItem:themeItem)
            }
        self.subviews.compactMap({$0 as? Themable}).forEach { $0.applyTheming()}
        }
        
    fileprivate func setAssociatedObject(_ object:Any,for key:inout String) 
        {
        objc_setAssociatedObject(self, &key, object, .OBJC_ASSOCIATION_RETAIN)
        }   
    
    fileprivate func associatedObject(for key:inout String) -> Any?     
        {
        return(objc_getAssociatedObject(self,&key))
        }
    }
