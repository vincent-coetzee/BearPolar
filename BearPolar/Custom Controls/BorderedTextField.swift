//
//  BorderedTextField.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedTextField: UITextField 
    {
    @IBInspectable var borderColor:UIColor
        {
        get
            {
            return(UIColor(cgColor: self.layer.borderColor!))
            }
        set(newColor)
            {
            self.layer.borderColor = newColor.cgColor
            }
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        defineStyle()
        }
    
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        defineStyle()
        }
    
    private func defineStyle()
        {
        self.layer.cornerRadius = ThemePalette.shared.textFieldCornerRadius 
        self.layer.borderColor = ThemePalette.shared.textFieldBorderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.backgroundColor = UIColor.black.cgColor
        self.textColor = ThemePalette.shared.textFieldBorderColor
        self.font = UIFont(name:"MuseoSans-500",size:14)
        self.text = "Some Sample Text"
        }
        
    public override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        ThemePalette.shared(for:type(of:self))
        defineStyle()
        }
    }
