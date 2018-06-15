//
//  NavigationBar.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar,Themable
    {
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.navigationBar)
        }
        
    override public func awakeFromNib()
        {
        super.awakeFromNib()
        prefersLargeTitles = true
//        applyTheming()
        self.barTintColor = .black
        self.tintColor = .white
        }
        
    func apply(themeItem:ThemeItem)
        {
        themeItem.apply(to: self)
        }
    }
