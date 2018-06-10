//
//  BearPolarTests.swift
//  BearPolarTests
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import XCTest
@testable import BearPolar

class BearPolarTests: XCTestCase 
    {
    
    let mainKeyTag = "com.macsemantics.bearpolar.vincent"
    
    override func setUp() 
        {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        }
    
    override func tearDown() 
        {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        }
    
    func testAAKeyGeneration()
        {
        let keychain = Keychain()
        var keys:Keychain.KeyPair? = nil
        do
            {
            keys = try keychain.generateKeys(tag: mainKeyTag,type:kSecAttrKeyTypeRSA,keyLength: ._2048)
            }
        catch
            {
            XCTFail("Exception occurred while generating keys")
            }
        XCTAssertNotNil(keys,"KeyPair should not be nil")
        XCTAssertNotNil(keys?.publicKey,"Public key should not be nil")
        XCTAssertNotNil(keys?.privateKey,"Public key should not be nil")
        }
        
    func testAZDeleteKeys()
        {
        let keychain = Keychain()
        let publicTag = "\(mainKeyTag).public"
        var result = keychain.deleteKey(forTag: publicTag)
        XCTAssert(result,"Deletion of public key failed")
        let privateTag = "\(mainKeyTag).private"
        result = keychain.deleteKey(forTag: privateTag)
        XCTAssert(result,"Deletion of private key failed")
        }
        
    func testABRoundTrip()
        {
        let keychain = Keychain()
        let publicKeyTag = "\(mainKeyTag).public"
        let privateKeyTag = "\(mainKeyTag).private"
        let publicKey = keychain.publicKey(forTag: publicKeyTag)
        let plainText = "Hello there possums, welcome down under 24/7"
        let cipherText = publicKey!.encryptedString(plainText)
        print(cipherText)
        let privateKey = keychain.privateKey(forTag: privateKeyTag)
        let decryptedText = privateKey!.decryptedString(cipherText!)
        print(decryptedText)
        }
}
