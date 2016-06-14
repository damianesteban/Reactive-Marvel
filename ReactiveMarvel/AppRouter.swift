//
//  AppRouter.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/29/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import UIKit

struct AppRouter {
    
    static func presentNavigationController(with viewController: UIViewController) {
        let navController = RMNavigationController(rootViewController: CharacterViewController())
        viewController.presentViewController(navController, animated: true, completion: nil)
    }
    
    static func presentDetailViewController(from viewController: UIViewController, toViewController:UIViewController) {
        viewController.presentViewController(toViewController, animated: true, completion: nil)
    }
}
