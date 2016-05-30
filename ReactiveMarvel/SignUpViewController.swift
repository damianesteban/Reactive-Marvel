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
    
    typealias ValidationResult = (valid: Bool, message: String)
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var submitSignupButton: UIButton!
    
    convenience init() {
        self.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextUI()
        
        let usernameValid = emailAddressTextField.rx_text
            .map { $0.characters.count >= 3 }
            .shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text
            .map { $0.characters.count >= 3 }
            .shareReplay(1)
        
        let combinedSignupValuesValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        usernameValid
            .bindTo(passwordTextField.rx_enabled)
            .addDisposableTo(disposeBag)
        
        combinedSignupValuesValid
            .bindTo(submitSignupButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        submitSignupButton.rx_tap
            .subscribeNext {
                print("User is validated")
                AppRouter.presentNavigationController(with: self)
            }
            .addDisposableTo(disposeBag)
        // Do any additional setup after loading the view.
    }
    
    func configureTextUI() {
        emailAddressTextField.placeholder = "username"
        emailAddressTextField.clearButtonMode = .WhileEditing
        passwordTextField.placeholder = "password"
        
    }
    
    // MARK: SignupValidator protocol methods
    func validateUsername(username: String) -> Observable<ValidationResult> {
        if username.characters.count == 0 {
            return Observable.just((false, "username is empty"))
        } else {
            return Observable.just((true, "username is valid"))
        }
    }
    
    func validatePassword(password: String) -> Observable<ValidationResult> {
        if password.characters.count == 0 {
            return Observable.just((false, "username is empty"))
        } else {
            return Observable.just((true, "password is valid"))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
