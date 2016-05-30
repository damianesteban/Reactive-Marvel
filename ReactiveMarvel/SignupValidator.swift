//
//  SignupValidator.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/29/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import RxSwift

protocol SignupValidator {
    associatedtype ValidationResult = Bool
    func validateUsername(username: String) -> ValidationResult
    func validatePassword(password: String) -> ValidationResult
}