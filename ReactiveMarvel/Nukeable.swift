//
//  Nukeable.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 7/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import Nuke

protocol Nukeable {
    func imageRequestWithNuke(urlString: String, imageView: UIImageView, size: CGSize)
}
