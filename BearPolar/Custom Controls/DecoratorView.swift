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
    @IBInspectable var topOn:Bool = false
        {
        didSet
            {
            var mask = self.layer.maskedCorners
            mask.remove(.layerMinXMinYCorner)
            mask.remove(.layerMaxXMinYCorner)
            if topOn
                {
                mask.insert(.layerMinXMinYCorner)
                mask.insert(.layerMaxXMinYCorner)
                }
            self.layer.maskedCorners = mask
            }
        }
        
    @IBInspectable var bottomOn:Bool = false
        {
        didSet
            {
            var mask = self.layer.maskedCorners
            mask.remove(.layerMinXMaxYCorner)
            mask.remove(.layerMaxXMaxYCorner)
            if bottomOn
                {
                mask.insert(.layerMinXMaxYCorner)
                mask.insert(.layerMaxXMaxYCorner)
                }
            self.layer.maskedCorners = mask
            }
        }
        
    @IBInspectable var borderColor:UIColor?
        {
        didSet
            {
            self.layer.borderColor = borderColor?.cgColor
            }
        }
        
    @IBInspectable var borderWidth:CGFloat = 0
        {
        didSet
            {
            self.layer.borderWidth = self.borderWidth
            }
        }
        
    @IBInspectable var cornerRadius:CGFloat = 0
        {
        didSet
            {
            self.layer.cornerRadius = self.cornerRadius
            }
        }
    }
