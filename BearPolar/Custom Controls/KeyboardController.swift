//
//  KeyboardController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class KeyboardController: NSObject 
    {
    @IBOutlet var scrollView:UIScrollView!
    var activeField:FocusField?
    
    @discardableResult
    func requestFocus(field:FocusField) -> Bool
        {
        if self.activeField == nil || self.activeField!.releaseFocus()
            {
            activeField?.didLoseFocus()
            activeField = field
            activeField?.didGainFocus()
            return(true)
            }
        return(false)
        }
    }
