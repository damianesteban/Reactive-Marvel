//
//  MarvelService.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/26/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import CryptoSwift
import Moya

struct CryptoKeys {
    
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

let cryptoKeys = CryptoKeys()

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data
    }
}


let MarvelAPIProvider = RxMoyaProvider<MarvelAPI>(plugins: [NetworkLoggerPlugin(verbose: true,
    responseDataFormatter: JSONResponseDataFormatter)])

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

enum MarvelAPI {
    case Supers(String)
}

extension MarvelAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://gateway.marvel.com/v1/public")! }
    var path: String {
        
        switch self {
        case .Supers(_):
            return "/characters"
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Supers(let query):
            return ["nameStartsWith": query,
                    "ts": cryptoKeys.ts,
                    "apikey": cryptoKeys.publicKey,
                    "hash": cryptoKeys.hash]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Supers(_):
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}