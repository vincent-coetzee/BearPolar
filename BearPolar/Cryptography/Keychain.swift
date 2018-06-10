//
//  Keychain.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation
import Security

public class Keychain
    {
    public typealias KeyPair = (privateKey:PrivateKey,publicKey:PublicKey)
    
    public enum KeyLength:Int
        {
        case _64 = 64
        case _128 = 128
        case _256 = 256
        case _512 = 512
        case _1024 = 1024
        case _2048 = 2048
        }
 
    internal var keychainTag:String = "" 
    internal var keyType:CFString = kSecAttrKeyTypeRSA
    internal var keyLength:Int = 2048
    
    public func privateKey(forTag tag:String) -> PrivateKey?
        {
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassKey
        query[kSecAttrApplicationTag as String] = tag
        query[kSecAttrKeyType as String] = kSecAttrKeyTypeRSA
        query[kSecReturnRef as String] = true
        var item:CFTypeRef? = nil
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess else
            {
            return(nil)
            }
        return(PrivateKey(item as! SecKey))
        }
        
    public func publicKey(forTag tag:String) -> PublicKey?
        {
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassKey
        query[kSecAttrApplicationTag as String] = tag
        query[kSecAttrKeyType as String] = kSecAttrKeyTypeRSA
        query[kSecReturnRef as String] = true
        var item:CFTypeRef? = nil
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess else
            {
            return(nil)
            }
        return(PublicKey(item as! SecKey))
        }
        
    public func deleteKey(forTag tag:String) -> Bool
        {
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassKey
        query[kSecAttrApplicationTag as String] = tag
        guard SecItemDelete(query as CFDictionary) == errSecSuccess else
            {
            return(false)
            }
        return(true)
        }
        
    public func generateKeys(tag:String,type:CFString,keyLength:KeyLength,storePrivate:Bool = true,storePublic:Bool = true) throws -> KeyPair
        {
        self.keychainTag = tag
        self.keyType = type
        self.keyLength = keyLength.rawValue
        return(try self.createKeys(storePublic:storePublic,storePrivate:storePrivate))
        }
    
    private func createKeys(storePublic:Bool,storePrivate:Bool) throws -> KeyPair
        {
        var attributes:[String:Any] = [:]
        attributes[kSecAttrKeyType as String] = self.keyType as Any
        attributes[kSecAttrKeySizeInBits as String] = self.keyLength as Any
        if storePrivate
            {
            let tag = "\(keychainTag).private".data(using: .utf8)
            var privateKeyAttributes:[String:Any] = [:]
            privateKeyAttributes[kSecAttrIsPermanent as String] = true as Any
            privateKeyAttributes[kSecAttrApplicationTag as String] = tag as Any
            attributes[kSecPrivateKeyAttrs as String] = privateKeyAttributes as Any
            }
        if storePublic
            {
            let tag = "\(keychainTag).public".data(using: .utf8)
            var publicKeyAttributes:[String:Any] = [:]
            publicKeyAttributes[kSecAttrIsPermanent as String] = true as Any
            publicKeyAttributes[kSecAttrApplicationTag as String] = tag as Any
            attributes[kSecPublicKeyAttrs as String] = publicKeyAttributes as Any
            }
        var error:Unmanaged<CFError>?
        guard let key = SecKeyCreateRandomKey(attributes as CFDictionary,&error) else
            {
            let throwable = error!.takeRetainedValue() as Error
            print(throwable)
            throw throwable
            }
        guard let publicKey = SecKeyCopyPublicKey(key) else
            {
            throw(NSError(domain: "security",code: 0,userInfo: nil))
            }
        return((privateKey:PrivateKey(key),publicKey:PublicKey(publicKey)))
        }
    }
