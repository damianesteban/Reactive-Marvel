//
//  SignUpViewController.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/29/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SignUpViewController: UIViewController, SignupValidator {
    
    typealias ValidationResult = Bool
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitSignupButton: UIButton!
    
    convenience init() {
        self.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reactive Marvel"
        configureUITextFields()
        
        // MARK: username and password validators
        let usernameValid = emailAddressTextField.rx_text
            .map { return self.validateUsername($0) }
            .shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text
            .map { self.validatePassword($0) }
            .shareReplay(1)
        
        let combinedSignupValuesValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        usernameValid
            .map { valid in
                return valid ? ColorPalette.GreenAccent : UIColor.clearColor()
            }.subscribeNext { [unowned self] color in
                self.emailAddressTextField.layer.borderColor = color.CGColor
            }.addDisposableTo(disposeBag)
        
        passwordValid
            .map { valid in
                return valid ? ColorPalette.GreenAccent : UIColor.clearColor()
            }.subscribeNext { [unowned self] color in
                self.passwordTextField.layer.borderColor = color.CGColor
            }.addDisposableTo(disposeBag)

        combinedSignupValuesValid
            .bindTo(submitSignupButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        submitSignupButton.rx_tap
            .subscribeNext {
                print("User is validated")
//                AppRouter.presentNavigationController(with: self)
            let cvc = CharacterViewController()
            self.navigationController?.pushViewController(cvc, animated: true)
            }
            .addDisposableTo(disposeBag)
    }
    
    // MARK: SignupValidator protocol methods
    func validateUsername(username: String) -> ValidationResult {
        return username.characters.count > 6 ? true : false
    }
    
    func validatePassword(password: String) -> ValidationResult {
        return password.characters.count > 6 ? true : false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SignUpViewController {
    
    func configureUITextFields() {
        emailAddressTextField.placeholder = "username"
        passwordTextField.placeholder = "password"
        
        emailAddressTextField.layer.borderWidth = 1
        passwordTextField.layer.borderWidth = 1
        
        InputCoordinator.configureEmail(emailAddressTextField)
        InputCoordinator.configurePassword(passwordTextField)
    }
}
