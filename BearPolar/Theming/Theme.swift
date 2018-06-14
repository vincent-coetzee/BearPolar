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
    public static var insets:UIEdgeInsets
        {
        return(UIEdgeInsets(top:10,left:10,bottom:10,right:10))
        }
        
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
            
        var nsTextAlignment:NSTextAlignment
            {
            switch(self)
                {
            case .left:
                return(.left)
            case .right:
                return(.right)
            case .justified:
                return(.justified)
            case .natural:
                return(.natural)
            case .center:
                return(.center)
                }
            }
        }
        
    public enum Key:String
        {
        case null
        case lime
        case tangerine
        case coral
        case midnight
        case canary
        }
        
    public enum EntryKey:String
        {
        case pinPad
        case header
        case textEntry
        case navigationBar
        case labeledButton
        }
    
    public static let DefaultThemeKey:Theme.Key = .tangerine
    
    private static var defaultBundle:Bundle = Bundle.main
    private static var themes:[Theme.Key:Theme] = [:]
    private static var _shared:Theme?
    
    public static var shared:Theme
        {
        if let shared = _shared
            {
            return(shared)
            }
        initThemes()
        _shared = themes[DefaultThemeKey]
        return(_shared!)
        }
    
    public static func initSharedTheme(for aClass:AnyClass)
        {
        let theBundle = Bundle(for: aClass)
        initThemes(in: theBundle)
        _shared = themes[DefaultThemeKey]
        }
        
    public static func initThemes(in bundle:Bundle = Bundle.main)
        {
        defaultBundle = bundle
        initTheme(key:.tangerine,colorPalette: ThemeColorPalette(primary: .tangerine))
        initTheme(key:.coral,colorPalette: ThemeColorPalette(primary: .coral))
        initTheme(key:.canary,colorPalette: ThemeColorPalette(primary: .canary))
        initTheme(key:.midnight,colorPalette: ThemeColorPalette(primary: .midnight))
        initTheme(key:.lime,colorPalette: ThemeColorPalette(primary: .lime))
        themes[.lime]?.testRatios()
        }
        
    private static func initTheme(key: Theme.Key,colorPalette:ThemeColorPalette)
        {
        let theme = Theme(key:key,colorPalette:colorPalette)
        themes[theme.key] = theme
        }
        
    public static func theme(at key:Theme.Key) -> Theme?
        {
        return(themes[key])
        }
        
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
        
    public typealias TextAttributes = [NSAttributedStringKey:Any]
    
    public private(set) var key:Key
    public private(set) var colorPalette:ThemeColorPalette
    
    internal var items = ThemeItemDictionary()
    
    public var primaryColor:UIColor
        {
        return(colorPalette.primaryColor)
        }
        
    public init(key:Key,colorPalette:ThemeColorPalette)
        {
        self.key = key
        self.colorPalette = colorPalette
        initItems()
        }
        
    private func initItems()
        {
        items["pinPad.digits.border"] = ThemeItem.border(borderColor:colorPalette.primaryColor,width:2.0)
        items["pinPad.content"] = ThemeItem.content(backgroundColor: .white)
        items["pinPad.keys.content"] = ThemeItem.content(backgroundColor:.clear,contentColor:colorPalette.primaryColor)
        items["pinPad.keys.text"] = ThemeItem.text(textColor:.black,font:UIFont.applicationFont(weight: .weight900, size: 40))
        items["header.content"] = ThemeItem.content(backgroundColor:colorPalette.primaryColor)
        items["header.border"] = ThemeItem.border(borderColor: colorPalette.primaryColor,width: 1)
        items["header.heading"] = ThemeItem.text(textColor: .black,font:UIFont.boldSystemFont(ofSize: 16),alignment: .center)
        items["header.help"] = ThemeItem.text(textColor: colorPalette.textColor,font:UIFont.boldSystemFont(ofSize: 12))
        items["navigationBar"] = ThemeItem.navigationBar(tint:.black,barTint: colorPalette.primaryColor,titleAttributes: [.foregroundColor: UIColor.black])
        items["textEntry.content"] = ThemeItem.content(backgroundColor:.white,highlightColor: colorPalette.primaryColor)
        items["textEntry.border"] = ThemeItem.border(borderColor: colorPalette.primaryColor,width: 1)
        items["textEntry.label.text"] = ThemeItem.text(textColor: colorPalette.textColor,font:themeFont(weight:.weight500,size:16))
        items["textEntry.field.text"] = ThemeItem.text(textColor: colorPalette.textColor,font:themeFont(weight:.weight500,size:16))
        items["labeledButton.content"] = ThemeItem.content(backgroundColor: .white)
        items["labeledButton.button.content"] = ThemeItem.content(backgroundColor: colorPalette.primaryColor)
        items["labeledButton.button.text"] = ThemeItem.text(textColor: .white,font:themeFont(weight:.weight500,size:16))
        items["labeledButton.label.text"] = ThemeItem.text(textColor: .darkGray,font:themeFont(weight:.weight500,size:16))
        items["labeledButton.border"] = ThemeItem.border(borderColor: colorPalette.primaryColor,width: 1)
        }
        
    private func testRatios()
        {
        let ratio1 = UIColor.darkGray.luminosityContrastRatio(with: .white)
        print("Ratio between dark gray and white \(ratio1)")
        let ratio2 = UIColor.white.luminosityContrastRatio(with: .lime)
        print("Ratio between white and lime \(ratio2)")
        let ratio = UIColor.lime.luminosityContrastRatio(with: .white)
        print("Ratio between lime and white \(ratio)")
        let ratio3 = UIColor.white.luminosityContrastRatio(with: .red)
        print("Ratio between red and white \(ratio3)")
        let ratio4 = UIColor.white.luminosityContrastRatio(with: .black)
        print("Ratio between black and white \(ratio4)")
        let limeHSB = UIColor.lime.hsbComponents
        print("Lime HSB\(limeHSB)")
        let grayHSB = UIColor.darkGray.hsbComponents
        print("Dark Gray HSB\(grayHSB)")
        let whiteHSB = UIColor.white.hsbComponents
        print("White HSB\(whiteHSB)")
        let greenHSB = UIColor.green.hsbComponents
        print("Green HSB\(greenHSB)")
        let darkGreenHSB = UIColor.gray.hsbComponents
        print("Gray HSB\(darkGreenHSB)")
        let newColor = UIColor.lime.tweakedToContrast(against: .white)
        }
        
    subscript(_ inputKey:Theme.EntryKey) -> ThemeItem?
        {
        get
            {
            return(items[ThemeItem.Path(inputKey)])
            }
        }
        
    subscript(_ inputKey:ThemeItem.Path) -> ThemeItem?
        {
        get
            {
            return(items[inputKey])
            }
        set
            {
            items[inputKey] = newValue
            }
        }
        
    func forItems(closure: (ThemeItem) -> ())
        {
        items.forEachValue
            {
            item in 
            closure(item)
            }
        }
        
    func themeFont(weight:UIFont.FontWeight,size:CGFloat) -> UIFont
        {
        let name = "MuseoSans-\(weight.rawValue)"
        return(UIFont(name:name,size:size)!)
        }
    }
