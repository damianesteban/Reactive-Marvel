//
//  Comic.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/1/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comic: JSONAbleType {
    let title: String
    let description: String
    
    let imageURLString: String
    
    static func fromJSON(json: JSON) -> Comic {
        let title = json["title"].stringValue
        let description = json["description"].stringValue
        let imagePath = json["images"][0]["path"].stringValue
        let imageExtension = json["images"][0]["extension"].stringValue
        let imageURLString = "\(imagePath).\(imageExtension)"
        return Comic(title: title, description: description, imageURLString: imageURLString)
    }
    
    static func arrayFromJSON(object: AnyObject) -> [Comic] {
        let json = JSON(object)
        return json["data"]["results"].arrayValue.map {
            return Comic.fromJSON($0)
        }
    }
}