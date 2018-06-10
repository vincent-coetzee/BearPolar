//
//  EditableView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class EditableView: UIView 
    {
    @IBInspectable var shadowColor:UIColor
        {
        get
            {
            guard let color = self.layer.shadowColor else
                {
                return(UIColor.clear)
                }
            return(UIColor(cgColor:color))
            }
        set(newValue)
            {
            self.layer.shadowColor = newValue.cgColor
            self.layer.shadowOffset = CGSize(width:0,height:0)
            }
        }
        
    
        
    @IBInspectable var bottomRounded:Bool
        {
        get
            {
            let corners = self.layer.maskedCorners
            return(corners.contains(.layerMaxXMaxYCorner) && corners.contains(.layerMinXMaxYCorner))
            }
        set(newValue)
            {
            var corners = self.layer.maskedCorners
            if newValue
                {
                corners.formUnion(.layerMaxXMaxYCorner)
                corners.formUnion(.layerMinXMaxYCorner)
                }
            else
                {
                corners.remove(.layerMaxXMaxYCorner)
                corners.remove(.layerMinXMaxYCorner)
                }
            self.layer.maskedCorners = corners
            }
        }
        
    @IBInspectable var topRounded:Bool
        {
        get
            {
            let corners = self.layer.maskedCorners
            return(corners.contains(.layerMaxXMinYCorner) && corners.contains(.layerMinXMinYCorner))
            }
        set(newValue)
            {
            var corners = self.layer.maskedCorners
            if newValue
                {
                corners.formUnion(.layerMaxXMinYCorner)
                corners.formUnion(.layerMinXMinYCorner)
                }
            else
                {
                corners.remove(.layerMaxXMinYCorner)
                corners.remove(.layerMinXMinYCorner)
                }
            self.layer.maskedCorners = corners
            }
        }
        
    @IBInspectable var borderCornerRadius:CGFloat
        {
        get
            {
            return(self.layer.cornerRadius)
            }
        set(newRadius)
            {
            self.layer.cornerRadius = newRadius
            }
        }
        
    @IBInspectable var shadowRadius:CGFloat
        {
        get
            {
            return(self.layer.shadowRadius)
            }
        set(newRadius)
            {
            self.layer.shadowRadius = newRadius
            }
        }
        
    @IBInspectable var shadowOpacity:Float
        {
        get
            {
            return(self.layer.shadowOpacity)
            }
        set(newRadius)
            {
            self.layer.shadowOpacity = newRadius
            }
        }
        
    @IBInspectable var borderWidth:CGFloat
        {
        get
            {
            return(self.layer.borderWidth)
            }
        set(width)
            {
            self.layer.borderWidth = width
            }
        }
        
    @IBInspectable var borderColor:UIColor
        {
        get
            {
            guard let color = self.layer.borderColor else
                {
                return(UIColor.clear)
                }
            return(UIColor(cgColor:color))
            }
        set(color)
            {
            self.layer.borderColor = color.cgColor
            }
        }
        
    }
