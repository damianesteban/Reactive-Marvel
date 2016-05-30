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
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitSignupButton: UIButton!
    
    convenience init() {
        self.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITextFields()
        
        // MARK: - Observables
        let usernameValid = emailAddressTextField.rx_text
            .map { return self.validateUsername($0) }
            .shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text
            .map { self.validatePassword($0) }
            .shareReplay(1)
        
        let combinedSignupValuesValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        // MARK: - Observers
        usernameValid
            .map { valid in
                return valid ? UIColor.greenColor() : UIColor.clearColor()
            }.subscribeNext { [unowned self] color in
                self.emailAddressTextField.layer.borderColor = color.CGColor
            }.addDisposableTo(disposeBag)
        
        passwordValid
            .map { valid in
                return valid ? UIColor.greenColor() : UIColor.clearColor()
            }.subscribeNext { [unowned self] color in
                self.passwordTextField.layer.borderColor = color.CGColor
            }.addDisposableTo(disposeBag)

        combinedSignupValuesValid
            .bindTo(submitSignupButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        submitSignupButton.rx_tap
            .subscribeNext {
                print("User is validated")
                AppRouter.presentNavigationController(with: self)
            }
            .addDisposableTo(disposeBag)
        
        //Observable.combineLatest(emailAddressTextField.rx_text, passwordTextField.rx_text) { textValueOne, textValueTwo in
            //return (Int(textValueOne) ?? 0) + (Int(textValueTwo) ?? 0)
            //}
            //.subscribeNext { number in
                //print(number)
        //}
        //.addDisposableTo(disposeBag)
    }
    
    // MARK: SignupValidator protocol methods
    func validateUsername(username: String) -> ValidationResult {
        return username.characters.count < 6 ? false : true
    }
    
    func validatePassword(password: String) -> ValidationResult {
        return password.characters.count < 6 ? false : true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SignUpViewController {
    
    func configureUITextFields() {
        emailAddressTextField.placeholder = "username"
        emailAddressTextField.clearButtonMode = .WhileEditing
        passwordTextField.placeholder = "password"
        passwordTextField.secureTextEntry = true
        
        emailAddressTextField.layer.borderWidth = 1
        passwordTextField.layer.borderWidth = 1
        
        appTitleLabel.font = UIFont.Font.Roboto.Regular.font(22)
    }
}
