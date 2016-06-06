//
//  APIKeys.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/6/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import CryptoSwift

struct APIKeys {
    
    let publicKey = "22cc06b67d2cf62d1f403125947e2baf"
    let privateKey = "7fa79982a543b54ad8283546fa16456ee613be18"
    let ts = String(random())
    
    var composite: String {
        return ts + privateKey + publicKey
    }
    
    var hash: String {
        return composite.md5()
    }
}