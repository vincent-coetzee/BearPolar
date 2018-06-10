//
//  PublicKey.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation
import Security

public class PublicKey:CryptographicKey
    {
    override var isPublicKey:Bool 
        {
        return(true)
        }
    }
