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
        let navController = RMNavigationController(rootViewController: BaseViewController())
        viewController.presentViewController(navController, animated: true, completion: nil)
    }
}
