//
//  PrivateKey.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation
import Security

public class PrivateKey:CryptographicKey
    {
    override var isPrivateKey:Bool 
        {
        return(true)
        }
    }
