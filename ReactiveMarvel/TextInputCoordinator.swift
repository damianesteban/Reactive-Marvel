//
//  TextInputCoordinator.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/6/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import UIKit

public class InputCoordinator: NSObject {
    static func configureText(textField: UITextField) {
        textField.keyboardType = .ASCIICapable
        textField.autocorrectionType = .Yes
        textField.autocapitalizationType = .None
    }
    
    static func configureEmail(textField: UITextField) {
        textField.keyboardType = .EmailAddress
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
    }
    
    static func configurePhone(textField: UITextField) {
        textField.keyboardType = .PhonePad
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
    }
    
    static func configurePassword(textField: UITextField) {
        textField.keyboardType = .ASCIICapable
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
        textField.secureTextEntry = true
    }
}