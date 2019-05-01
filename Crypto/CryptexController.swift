//
//  CryptexController.swift
//  Crypto
//
//  Created by Alex on 5/1/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class CryptexController {
    
    private (set) var cryptex = [Cryptex]()
    var currentCryptex: Cryptex?
    
    init() {
        randomCryptex() // called when CryptexController class is called
        
        cryptex.append(Cryptex(password: "ALEX", hint: "The best name out there"))
        cryptex.append(Cryptex(password: "UBER", hint: "A ride-sharing company"))
    }
    
    func randomCryptex(){
        // grab random index from cryptex
        currentCryptex = cryptex.randomElement() // not sure if this is correct
    }
    
    
    
}
