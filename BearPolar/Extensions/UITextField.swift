//
//  UITextField.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension UITextField
    {
    func applyTheme(_ theme:Theme)
        {
        theme.forItems
            {
            item in
            item.apply(to: self)
            }
        }
    }
