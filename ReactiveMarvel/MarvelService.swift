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

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

let keys = APIKeys()

let MarvelAPIProvider = RxMoyaProvider<MarvelAPI>(plugins: [NetworkLoggerPlugin(verbose: true,
    responseDataFormatter: JSONResponseDataFormatter)])

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

enum MarvelAPI {
    case Characters(String), Comics(String)
}

extension MarvelAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://gateway.marvel.com/v1/public")! }
    var path: String {
        
        switch self {
        case .Characters(_):
            return "/characters"
        case .Comics(let characterId):
            return "/characters/\(characterId)/comics"
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Characters(let query):
            return ["nameStartsWith": query,
                    "ts": keys.ts,
                    "apikey": keys.publicKey,
                    "hash": keys.hash]
        case .Comics(_):
            return ["ts": keys.ts,
                    "apikey": keys.publicKey,
                    "hash": keys.hash,
                    "limit": 20]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Characters(_):
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        case .Comics(_):
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}