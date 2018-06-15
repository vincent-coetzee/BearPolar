//
//  DecoratorView.swift
//  Designable
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class DecoratorView: UIView 
    {
    private var topMask:UInt
        {
        if self.topOn
            {
            return(CACornerMask.layerMinXMinYCorner.rawValue | CACornerMask.layerMaxXMinYCorner.rawValue)
            }
        else
            {
            return(0)
            }
        }
        
    private var bottomMask:UInt
        {
        if self.bottomOn
            {
            return(CACornerMask.layerMinXMaxYCorner.rawValue | CACornerMask.layerMaxXMaxYCorner.rawValue)
            }
        else
            {
            return(0)
            }
        }
        
    @IBInspectable var topOn:Bool = false
        {
        didSet
            {
            self.layer.maskedCorners = CACornerMask(rawValue: self.topMask | self.bottomMask)
            self.layer.setNeedsDisplay()
            }
        }
        
    @IBInspectable var bottomOn:Bool = false
        {
        didSet
            {
            self.layer.maskedCorners = CACornerMask(rawValue: self.topMask | self.bottomMask)
            self.layer.setNeedsDisplay()
            }
        }
        
    @IBInspectable var borderColor:UIColor?
        {
        didSet
            {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.setNeedsDisplay()
            }
        }
        
    @IBInspectable var borderWidth:CGFloat = 0
        {
        didSet
            {
            self.layer.borderWidth = self.borderWidth
            self.layer.setNeedsDisplay()
            }
        }
        
    @IBInspectable var cornerRadius:CGFloat = 0
        {
        didSet
            {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.setNeedsDisplay()
            }
        }
    }
