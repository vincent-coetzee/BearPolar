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
        palette = palettes[.coral]!
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
        initAquaTheme()
        initTangerineTheme()
        initCoralTheme()
        initCanaryTheme()
        initMidnightTheme()
        }
        
    public var dominantColor:UIColor
        {
        return(.coral)
        }
        
    public func initTangerineTheme()
        {
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:.tangerine,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:.tangerine)
        theme["keys.text"] = ThemeItem.text(textColor:.black,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:UIColor.tangerine)
        theme["border"] = ThemeItem.border(borderColor: .tangerine,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 16))
        theme["help"] = ThemeItem.text(textColor: .darkGray,font:UIFont.boldSystemFont(ofSize: 12))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: .tangerine,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: .tangerine)
        theme["border"] = ThemeItem.border(borderColor:.tangerine,width: 1)
        theme["label.text"] = ThemeItem.text(textColor:.darkGray,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor:.darkGray,font:font(size:16))
        themes[theme.key] = theme
        theme["palette"] = ThemeColorPalette(primary: .tangerine)
        themes[theme.key] = theme
        palettes[.tangerine] = themes
        }
        
    public func initCoralTheme()
        {
        let darkCoral = UIColor.coral.muchDarker
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:.coral,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:.coral)
        theme["keys.text"] = ThemeItem.text(textColor:darkCoral,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:UIColor.coral)
        theme["border"] = ThemeItem.border(borderColor: darkCoral,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 18))
        theme["help"] = ThemeItem.text(textColor: darkCoral,font:UIFont.boldSystemFont(ofSize: 14))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: .coral,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: .coral)
        theme["border"] = ThemeItem.border(borderColor: darkCoral,width: 1)
        theme["label.text"] = ThemeItem.text(textColor:.coral,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor: darkCoral,font:font(size:16))
        themes[theme.key] = theme
        theme = Theme(.palette)
        theme["palette"] = ThemeColorPalette(primary: .coral)
        themes[theme.key] = theme
        palettes[.coral] = themes
        }
        
    public func initCanaryTheme()
        {
        let darkCanary = UIColor.canary.muchDarker
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:.coral,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:.canary)
        theme["keys.text"] = ThemeItem.text(textColor:darkCanary,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:UIColor.canary)
        theme["border"] = ThemeItem.border(borderColor: darkCanary,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 18))
        theme["help"] = ThemeItem.text(textColor: darkCanary,font:UIFont.boldSystemFont(ofSize: 14))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: .canary,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: .canary)
        theme["border"] = ThemeItem.border(borderColor: darkCanary,width: 1)
        theme["label.text"] = ThemeItem.text(textColor:.canary,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor: darkCanary,font:font(size:16))
        themes[theme.key] = theme
        theme = Theme(.palette)
        theme["palette"] = ThemeColorPalette(primary: .canary)
        themes[theme.key] = theme
        palettes[.canary] = themes
        }
        
    public func initMidnightTheme()
        {
        let darkMidnight = UIColor.canary.muchDarker
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:.midnight,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:.midnight)
        theme["keys.text"] = ThemeItem.text(textColor:darkMidnight,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:UIColor.midnight)
        theme["border"] = ThemeItem.border(borderColor: darkMidnight,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 18))
        theme["help"] = ThemeItem.text(textColor: darkMidnight,font:UIFont.boldSystemFont(ofSize: 14))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: .midnight,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: .midnight)
        theme["border"] = ThemeItem.border(borderColor: darkMidnight,width: 1)
        theme["label.text"] = ThemeItem.text(textColor:.midnight,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor: darkMidnight,font:font(size:16))
        themes[theme.key] = theme
        theme = Theme(.palette)
        theme["palette"] = ThemeColorPalette(primary: .midnight)
        themes[theme.key] = theme
        palettes[.midnight] = themes
        }
        
    public func initAquaTheme()
        {
        var themes:[Theme.Key:Theme] = [:]
        var theme = Theme(.pinPad)
        themes[theme.key] = theme
        theme["digits"] = ThemeItem.childTheme()
        theme["digits.border"] = ThemeItem.border(borderColor:.aqua,width:2.0)
        theme["content"] = ThemeItem.content(backgroundColor: .white)
        theme["keys"] = ThemeItem.childTheme()
        theme["keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:.aqua)
        theme["keys.text"] = ThemeItem.text(textColor:.black,font:UIFont.applicationFont(weight: .weight900, size: 40))
        theme = Theme(.header)
        themes[theme.key] = theme
        theme["content"] = ThemeItem.content(backgroundColor:UIColor.aqua)
        theme["border"] = ThemeItem.border(borderColor: .aqua,width: 1)
        theme["heading"] = ThemeItem.text(textColor: .white,font:UIFont.boldSystemFont(ofSize: 18))
        theme["help"] = ThemeItem.text(textColor: .white,font:UIFont.boldSystemFont(ofSize: 14))
        themes[theme.key] = theme
        theme = Theme(.navigationBar)
        themes[theme.key] = theme
        theme["bar"] = ThemeItem.navigationBar(tint:.black,barTint: .aqua,titleAttributes: [.foregroundColor: UIColor.black])
        theme = Theme(.textEntry)
        themes[theme.key] = theme
        theme["label"] = ThemeItem.childTheme()
        theme["field"] = ThemeItem.childTheme()
        theme["content"] = ThemeItem.content(backgroundColor:.white,highlightColor: .aqua)
        theme["border"] = ThemeItem.border(borderColor:.aqua,width: 1)
        theme["label.text"] = ThemeItem.text(textColor:.darkGray,font:font(size:16))
        theme["field.text"] = ThemeItem.text(textColor:.darkGray,font:font(size:16))
        themes[theme.key] = theme
        theme["palette"] = ThemeColorPalette(primary: .blue)
        themes[theme.key] = theme
        palettes[.aqua] = themes
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
