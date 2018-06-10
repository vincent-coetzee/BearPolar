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
    var theme:Theme? { get }
    var themeKey:Theme.Key? { get }
    var themeName:String? { get set }
    func applyTheme()
    func applyTheme(_ theme:Theme)
    }
    
fileprivate var KeyForKey = "__KEY_FOR_THEME_KEY__"

extension Themable where Self:UIView
    {        
    public var themeKey:Theme.Key?
        {
        guard let name = self.themeName else
            {
            return(nil)
            }
        return(Theme.Key(rawValue:name))
        }
        
    public var themeName:String?
        {
        get
            {
            return(self.associatedObject(for: &KeyForKey) as? String)
            }
        set(newThemeName)
            {
            self.setAssociatedObject(newThemeName as Any,for: &KeyForKey)
            (self as Themable).applyTheme()
            }
        }
        
    public var theme:Theme?
        {
        guard let key = self.themeKey else
            {
            return(nil)
            }
        return(ThemePalette.shared[key])
        }
        
    public func applyTheme()
        {
        if let theme = self.theme
            {
            self.applyTheme(theme)
            }
        self.subviews.compactMap({$0 as? Themable}).forEach { $0.applyTheme()}
        }
        
    public func applyTheme(_ theme:Theme)
        {
        theme.forItems
            {
            item in
            item.apply(to:self)
            }
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
