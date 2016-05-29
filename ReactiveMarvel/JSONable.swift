//
//  JSONable.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/26/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONAbleType {
    static func fromJSON(json: JSON) -> Self
}