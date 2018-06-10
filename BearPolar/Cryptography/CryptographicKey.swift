//
//  CryptographicKey.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation
import Security

public class CryptographicKey
    {
    private let key:SecKey
    
    var isPublicKey:Bool 
        {
        return(false)
        }
        
    var isPrivateKey:Bool 
        {
        return(false)
        }
        
    init(_ key:SecKey)
        {
        self.key = key
        }
        
    init?( _ string:String)
        {
        return(nil)
        }
        
    var blockSize:Int
        {
        return(SecKeyGetBlockSize(key))
        }
        
    public var base64KeyText:String?
        {
        guard let data = SecKeyCopyExternalRepresentation(key,nil) else
            {
            return(nil)
            }
        let string = (data as? Data)?.base64EncodedString(options: .lineLength64Characters)
        return(string)
        }
        
    public func encryptedString(_ string:String) -> String?
        {
        guard let input = string.data(using: .utf8) else
            {
            return(nil)
            }
        let bufferSize = ((input.count / self.blockSize) + 1)*self.blockSize
        var buffer = Data(count: bufferSize)
        var outputLength:Int = bufferSize
        let status = buffer.withUnsafeMutableBytes
            {
            (outputBytes:UnsafeMutablePointer<UInt8>) -> OSStatus in
            let status = input.withUnsafeBytes
                {
                (inputBytes:UnsafePointer<UInt8>) -> OSStatus in
                let status = SecKeyEncrypt(key, .PKCS1, inputBytes, input.count, outputBytes, &outputLength)
                return(status)
                }
            return(status)
            }
        guard status == errSecSuccess else
            {
            return(nil)
            }
        let output = buffer.base64EncodedString(options: .lineLength64Characters)
        return(output)
        }
        
    public func decryptedString(_ string:String) -> String?
        {
        guard let input = Data(base64Encoded: string,options: .ignoreUnknownCharacters) else
            {
            return(nil)
            }
        let bufferSize = self.blockSize
        var buffer = Data(count: bufferSize)
        var outputLength:Int = bufferSize
        let status = buffer.withUnsafeMutableBytes
            {
            (outputBytes:UnsafeMutablePointer<UInt8>) -> OSStatus in
            let status = input.withUnsafeBytes
                {
                (inputBytes:UnsafePointer<UInt8>) -> OSStatus in
                let status = SecKeyDecrypt(key, .PKCS1, inputBytes, input.count, outputBytes, &outputLength)
                return(status)
                }
            return(status)
            }
        guard status == errSecSuccess else
            {
            return(nil)
            }
        buffer.count = outputLength
        let output = String(data: buffer,encoding: .utf8)
        return(output)
        }
    }
