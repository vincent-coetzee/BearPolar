//
//  ThemeColorPalette.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/13.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class ThemeColorPalette
    {
    public let primaryColor:UIColor
    public let darkColor:UIColor
    public let lightColor:UIColor
    public let textColor:UIColor
    
    init(primary:UIColor,dark:UIColor,light:UIColor,text:UIColor)
        {
        primaryColor = primary
        darkColor = dark
        lightColor = light
        textColor = text
        }
    
    convenience init(primary:UIColor)
        {
        self.init(primary:primary,dark:primary.darker,light:primary.lighter,text: .darkGray)
        }
    }
