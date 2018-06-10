//
//  PIN.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public struct PIN:Equatable
    {
    public static let standardPINLength = 6
    
    public static func ==(lhs:PIN,rhs:PIN) -> Bool
        {
        return(lhs.digits == rhs.digits)
        }
        
    private var digits:[Character] = []
    
    public var isComplete:Bool
        {
        return(digits.count == PIN.standardPINLength)
        }
        
    public var count:Int
        {
        return(digits.count)
        }
        
    public mutating func appendDigit(_ character:Character)
        {
        if digits.count < PIN.standardPINLength
            {
            digits.append(character)
            }
        }
        
    public mutating func dropLastDigit()
        {
        if digits.count > 0
            {
            digits = Array(digits.dropLast())
            }
        }
    }
