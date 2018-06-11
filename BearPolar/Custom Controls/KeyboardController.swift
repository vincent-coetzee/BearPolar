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
    var activeField:FocusField?
        {
        didSet(oldField)
            {
            oldField?.didLoseFocus()
            activeField?.didGainFocus()
            }
        }
    }
