//
//  ColorsFontsImages.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/30/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import UIKit

/// Color Palette
struct ColorPalette {
    static let BluePrimary = UIColor(red:0.13, green:0.58, blue:0.95, alpha:1.00)
    static let RedAccent = UIColor(red:1.00, green:0.32, blue:0.32, alpha:1.00)
    static let WhitePrimary = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
    static let WhiteBackground = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
    static let BlackPrimary = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.00)
    static let GraySecondary = UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.00)
    static let GrayDivider = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.00)
}

protocol FontConvertible {
    func font(size: CGFloat) -> UIFont
}
/// Fonts
extension UIFont {
    struct Font {
        enum Roboto: String, FontConvertible {
            case Regular = "Roboto-Regular"
            case Italic = "Roboto-Italic"
            case Bold = "Roboto-Bold"
            
            func font(size: CGFloat) -> UIFont { return UIFont(name:self.rawValue, size:size)!}
        }
    }
}

extension UIFont {
    
    class func avenirNextFont(size size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size)!
    }
    
    class func avenirNextBoldFont(size size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
    }
}