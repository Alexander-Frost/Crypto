//
//  CryptexController.swift
//  Crypto
//
//  Created by Alex on 5/1/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        randomCryptex() // called when CryptexController class is called
    }
    
    
    private (set) var cryptex = [Cryptex]()
    
    var currentCryptex: Cryptex?
    
    func randomCryptex(){
        // grab random index from cryptex
        currentCryptex = cryptex.randomElement() // not sure if this is correct
    }
    
    
    
}
