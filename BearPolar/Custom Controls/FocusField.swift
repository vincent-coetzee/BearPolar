//
//  FocusField.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public protocol FocusField
    {
    func didLoseFocus()
    func didGainFocus()
    }
