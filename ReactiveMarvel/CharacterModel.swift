//
//  Photo.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/26/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CharacterModel: JSONAbleType {

    let name: String
    let description: String
    let imageURLString: String
    
    static func fromJSON(json: JSON) -> CharacterModel {
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        let imagePath = json["thumbnail"]["path"].stringValue
        let imageExtension = json["thumbnail"]["extension"].stringValue
        let imageURLString = "\(imagePath).\(imageExtension)"
        return CharacterModel(name: name, description: description, imageURLString: imageURLString)
    }
    
    static func arrayFromJSON(object: AnyObject) -> [CharacterModel] {
        let json = JSON(object)
        return json["data"]["results"].arrayValue.map {
            return CharacterModel.fromJSON($0)
        }
    }
    
}