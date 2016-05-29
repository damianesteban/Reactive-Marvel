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
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    convenience init() {
        self.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usernameValid = emailAddressTextField.rx_text
            .map { self.validateUsername($0) }
            .shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text
            .map { self.validatePassword($0) }
            .shareReplay(1)
        
        

        // Do any additional setup after loading the view.
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
