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
    
    public var themeKey:Theme.Key?
        {
        return(Theme.Key.navigationBar)
        }
        
    override public func awakeFromNib()
        {
        super.awakeFromNib()
        self.theme?.forItems
            {
            item in
            item.apply(to:self)
            }
        }
    }
