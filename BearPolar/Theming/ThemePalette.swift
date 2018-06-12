//
//  StylePalette.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class ThemePalette
    {
    private let bundle:Bundle 
    private var palettes:[Theme.Key:[Theme.Key:Theme]] = [:]
    private var palette:[Theme.Key:Theme] = [:]
    
    private let NavigationBarTintColorName = "Color.NavigationBarTint"
    private let NavigationBarTitleTextColorName = "Color.NavigationBarTitleText"
    private let ActionTextColorName = "Color.ActionText"
    private let PrimaryTextColorName = "Color.PrimaryText"
    public let TextFontName = "MuseoSans"
    public let KeypadFontName = "MuseoSans-900"
    private let HighlightColorName = "Color.Highlight"
    private let NumberPadDigitColorName = "Color.NumberPadDigit"
    private let TextFieldBorderColorName = "Color.TextFieldBorder"
    public static func dumpAllFontNames() 
        {
        var fontNames: [String] = []
        for familyName in UIFont.familyNames 
            {
            for fontName in UIFont.fontNames(forFamilyName: familyName) 
                {
                fontNames.append(fontName)
                }
            }
        fontNames = fontNames.sorted()
        for name in fontNames 
            {
            print(name)
            }
        }
        
    private static var _sharedInstance = ThemePalette(for: ThemePalette.self)
    
    subscript(_ key:Theme.Key) -> Theme
        {
        return(palette[key]!)
        }
        
    public static var shared:ThemePalette
        {
        return(_sharedInstance)
        }
        
    public static func shared(for aClass:AnyClass)
        {
        _sharedInstance = ThemePalette(for: aClass)
        }
        
    private init(for aClass:AnyClass)
        {
        bundle = Bundle(for: aClass)
        initThemes()
        palette = palettes[.lime]!
        }

    fileprivate func color(named name:String) -> UIColor
        {
        guard let color = UIColor(named: name,in: bundle,compatibleWith: nil) else
            {
            fatalError("Color named \(name) not found")
            }
        return(color)
        }
        
    fileprivate func font(size:CGFloat) -> UIFont
        {
        guard let font = UIFont(name:"MuseoSans-500",size:size) else
            {
            fatalError("Font MuseoSans \(size) not found")
            }
        return(font)
        }
            
    public func initThemes()
        {
        initTheme(key: .tangerine,primary: .tangerine,darker: UIColor.tangerine.darker,lighter:UIColor.tangerine.lighter)
        initTheme(key: .coral,primary: .coral,darker: UIColor.coral.darker,lighter:UIColor.coral.lighter)
        initTheme(key: .canary,primary: .canary,darker: UIColor.canary.darker,lighter:UIColor.canary.lighter)
        initTheme(key: .midnight,primary: .midnight,darker: UIColor.midnight.darker,lighter:UIColor.midnight.lighter)
        initTheme(key: .lime,primary: .lime,darker: UIColor.lime.darker,lighter:UIColor.lime.lighter)
        }
        
    public var dominantColor:UIColor
        {
        return(.lime)
        }
        
    public func initTheme(key:Theme.Key,primary:UIColor,darker:UIColor,lighter:UIColor)
        {
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:primary,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:primary)
        theme["keys.text"] = ThemeItem.text(textColor:.black,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:primary)
        theme["border"] = ThemeItem.border(borderColor: primary,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 16))
        theme["help"] = ThemeItem.text(textColor: .darkGray,font:UIFont.boldSystemFont(ofSize: 12))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: primary,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: primary)
        theme["border"] = ThemeItem.border(borderColor: primary,width: 1)
        theme["label.text"] = ThemeItem.text(textColor: .darkGray,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor: .darkGray,font:font(size:16))
        themes[theme.key] = theme
        theme["palette"] = ThemeColorPalette(primary: primary)
        themes[theme.key] = theme
        palettes[key] = themes
        }
        
    public var highlightColor:UIColor
        {
        return(UIColor(named:HighlightColorName,in: bundle,compatibleWith: nil)!)
        }
        
    public var actionTextColor:UIColor
        {
        return(UIColor(named: ActionTextColorName,in: bundle,compatibleWith: nil)!)
        }
        
    public var primaryTextColor:UIColor
        {
        return(UIColor(named: PrimaryTextColorName,in: bundle,compatibleWith: nil)!)
        }
        
    public var numberPadDigitColor:UIColor
        {
        return(UIColor(named: NumberPadDigitColorName,in: bundle,compatibleWith: nil)!)
        }
        
    public var textFieldCornerRadius:CGFloat
        {
        return(8.0)
        }
    
    public var textFieldBorderColor:UIColor
        {
        return(UIColor(named: TextFieldBorderColorName,in: bundle,compatibleWith: nil)!)
        }
    }
