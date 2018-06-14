//
//  UIColor+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public extension UIColor
    {
    struct HSB
        {
        let hue:CGFloat
        let saturation:CGFloat
        let brightness:CGFloat
        let alpha:CGFloat
        
        init(hue:CGFloat,saturation:CGFloat,brightness:CGFloat,alpha:CGFloat)
            {
            self.hue = hue
            self.brightness = brightness
            self.saturation = saturation
            self.alpha = alpha
            }
        }
        
    struct RGBA
        {
        let red:CGFloat
        let green:CGFloat
        let blue:CGFloat
        let alpha:CGFloat
        
        static func *(lhs:RGBA,rhs:CGFloat) ->RGBA
            {
            return(RGBA(red:lhs.red*rhs,green:lhs.green*rhs,blue:lhs.blue*rhs,alpha:lhs.alpha*rhs))
            }
            
        static func +(lhs:RGBA,rhs:RGBA) -> RGBA
            {
            return(RGBA(red:lhs.red+rhs.red,green:lhs.green+rhs.green,blue:lhs.blue+rhs.blue,alpha:lhs.alpha+rhs.alpha))
            }
            
        init(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)
            {
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
            }
        }
        
    class var fullWhite:UIColor
        {
        return(UIColor(red:1.0,green:1.0,blue:1.0,alpha:1))
        }
        
    class var fullBlack:UIColor
        {
        return(UIColor(red:0,green:0,blue:0,alpha:1))
        }
        
    class var canary:UIColor
        {
        return(UIColor(red: 241.0/255.0,green: 162.0/255.0,blue:57.0/255.0,alpha: 1.0))
        }
        
    class var midnight:UIColor
        {
        return(UIColor(red: 120.0/255.0,green: 39.0/255.0,blue: 159.0/255.0,alpha: 1.0))
        }
        
    class var coral:UIColor
        {
        return(UIColor(red: 230.0/255.0,green: 45.0/255.0,blue: 69.0/255.0,alpha: 1.0))
        }
    
    class var tangerine:UIColor
        {
        return(UIColor(red:1,green:0.578,blue:0,alpha:1))
        }
        
    class var lime:UIColor
        {
        return(UIColor(red:0.556,green:0.979,blue:0,alpha:1))
        }
        
    class var aqua:UIColor
        {
        return(UIColor(red:0,green:0.590,blue:1,alpha:1))
        }
        
    class var pureGreen:UIColor
        {
        return(UIColor(red:0,green:166.0/255.0,blue:81.0/255.0,alpha:1))
        }
        
    class var yellowGreen:UIColor
        {
         return(UIColor(red:10.0/255.0,green:190.0/255.0,blue:50.0/255.0,alpha:1))
        }
        
    convenience init(_ components:RGBA)
        {
        self.init(red:components.red,green:components.green,blue:components.blue,alpha:components.alpha)
        }
        
    var rgbaComponents:RGBA
        {
        let pieces = self.cgColor.components!
        if pieces.count == 2
            {
            return(RGBA(red:pieces[0],green:pieces[0],blue:pieces[0],alpha:pieces[1]))
            }
        return(RGBA(red:pieces[0],green:pieces[1],blue:pieces[2],alpha:pieces[3]))
        }
        
    func alphaMixed(with color:UIColor,proportionOfSelf proportion:CGFloat) -> UIColor
        {
        let fraction1 = max(0.0,min(proportion,1.0))
        let fraction2 = 1.0 - fraction1
        let multiple1 = self.rgbaComponents * fraction1
        let multiple2 = color.rgbaComponents * fraction2
        let newColor = multiple1 + multiple2
        return(UIColor(newColor))
        }
        
    var hsbComponents:HSB
        {
        var hue:CGFloat = 0
        var brightness:CGFloat
        var saturation:CGFloat
        
        let components = self.rgbaComponents
        let rgbMin = min(min(components.red,components.green),components.blue) 
        let rgbMax = max(max(components.red,components.green),components.blue) 
        if rgbMin == rgbMax
            {
            hue = 0
            }
        else if rgbMax == components.red
            {
            hue = 60.0 * ((components.green - components.blue) / (rgbMax - rgbMin))
            hue = CGFloat(fmodf(Float(hue),360.0))
            }
        else if rgbMax == components.green
            {
            hue = 60.0 * ((components.blue - components.red) / (rgbMax - rgbMin)) + 120.0
            }
        else if rgbMax == components.blue
            {
            hue = 60.0 * ((components.red - components.green) / (rgbMax - rgbMin)) + 240.0
            }
        brightness = rgbMax
        if rgbMax == 0
            {
            saturation = 0.0
            }
        else
            {
            saturation = 1.0 - (rgbMin / rgbMax)
            }
        hue = hue / 360.0
        return(HSB(hue:hue,saturation:saturation,brightness:brightness,alpha: components.alpha))
        }
        
    var perceivedBrightness:CGFloat
        {
        let pieces = rgbaComponents
        let (r,g,b) = (pieces.red*pieces.red,pieces.green*pieces.green,pieces.blue*pieces.blue)
        let perceivedBrightness = sqrt(0.241*r + 0.691*g + 0.068*b)
        return(perceivedBrightness)
        }
        
    var luminosity:CGFloat
        {
        let rgba = rgbaComponents
        let (r,g,b) = (pow(rgba.red,2.2),pow(rgba.green,2.2),pow(rgba.blue,2.2))
        let luminosity = 0.2126*r + 0.7152*g + 0.00722*b 
        let perceivedBrightness = sqrt(0.241*r + 0.691*g + 0.068*b)
        return(perceivedBrightness)
        }
        
    func luminosityContrastRatio(with color:UIColor) -> CGFloat
        {
        let l1 = self.luminosity
        let l2 = color.luminosity
        let ratio = (max(l1,l2)+0.05) / (min(l1,l2)+0.05)
        return(ratio)
        }
        
    func tweakedToContrast(against other:UIColor) -> UIColor
        {
        let targetRatio:CGFloat = 3.0
        let maximumMix:CGFloat = 1.0
        
        let contrastRatio = self.contrastRatio(with:other)
        if contrastRatio >= targetRatio
            {
            return(self)
            }
        let mixInColor = other.perceivedBrightness > self.perceivedBrightness ? UIColor.black : UIColor.white
        let ratio = min((targetRatio - contrastRatio),targetRatio) / targetRatio
        let delta = 1.0 - ratio
        print("self contrastRatio = \(contrastRatio)")
        let newColor = self.alphaMixed(with: mixInColor, proportionOfSelf: ratio)
        let newContrastRatio = newColor.contrastRatio(with: other)
        print("newColor contrastRatio = \(newContrastRatio)")
        return(newColor)
        }
        
    func contrastsPoorly(with: UIColor) -> Bool
        {
        return(self.contrastRatio(with:with) < 3.0)
        }
        
    func contrastRatio(with toColor:UIColor) -> CGFloat
        {
        let pb1 = self.perceivedBrightness
        let pb2 = toColor.perceivedBrightness
        let (l1,l2) = pb1 > pb2 ? (pb1,pb2) : (pb2,pb1)
        let contrastRatio = (l1+0.05)/(l2 + 0.05)
        return(contrastRatio)
        }
        
    var lighter:UIColor
        {
        return(adjust(saturationBy:0.03,brightnessBy:0.08))
        }
        
    func adjust(saturationBy saturation:CGFloat,brightnessBy brightness:CGFloat) -> UIColor
        {
        let alpha = self.rgbaComponents.alpha
        let hsb = self.hsbComponents
        return(UIColor(hue: hsb.hue,saturation: hsb.saturation + max(0.005,min(saturation,1.0)),brightness: hsb.brightness + max(0.005,min(brightness,1.0)),alpha: alpha))
        }
        
    var darker:UIColor
        {
        return(adjust(brightnessBy: -0.08))
        }
        
    var blacker:UIColor
        {
        return(self.alphaMixed(with:.fullBlack,proportionOfSelf:0.8333))
        }
        
    var whiter:UIColor
        {
        return(self.alphaMixed(with:.fullWhite,proportionOfSelf:0.8333))
        }
        
    var slightlyDarker:UIColor
        {
        return(adjust(brightnessBy:-0.03))
        }
        
    var slightlyLighter:UIColor
        {
        return(adjust(saturationBy: -0.01,brightnessBy:0.03))
        }
        
    var muchDarker:UIColor
        {
        return(self.alphaMixed(with:.fullBlack,proportionOfSelf:0.5))
        }
        
    var paler:UIColor
        {
        return(adjust(saturationBy: -0.09,brightnessBy:0.09))
        }
        
    func adjust(brightnessBy brightness:CGFloat) -> UIColor
        {
        let alpha = self.rgbaComponents.alpha
        let hsb = self.hsbComponents
        return(UIColor(hue: hsb.hue,saturation: hsb.saturation,brightness: hsb.brightness + max(0.005,min(brightness,1.0)),alpha: alpha))
        }
    }
