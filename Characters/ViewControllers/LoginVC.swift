//
//  LoginVC.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 30.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = " Welcome!"
    }
    
//    MARK: - Actions
    @IBAction func segmentedControlAction(_ sender: Any) {
        nameTextField.isHidden = segmentedControl.selectedSegmentIndex != 0
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
        let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let name = nameTextField.text, !name.isEmpty else {
                return
            }
            AuthService.signup(with: name, email: email, password: password, success: { [weak self] (response) in
                debugPrint(response)
                guard response.success else {
                    let errorMessages = response.errors?.compactMap({$0.message + "\n"})
                    self?.errorAlert(with: errorMessages?.joined())
                    return
                }
                self?.performSegue(withIdentifier: "gotoLocaleVC", sender: self)
            }) { (error) in
                debugPrint(error)
            }
        } else {
            AuthService.login(with: email, password: password, success: { [weak self] (response) in
                debugPrint(response)
                guard response.success else {
                    let errorMessages = response.errors?.compactMap({$0.message + "\n"})
                    self?.errorAlert(with: errorMessages?.joined())
                    return
                }
                self?.performSegue(withIdentifier: "gotoLocaleVC", sender: self)
            }) { (error) in
                debugPrint(error)
            }
        }
    }
    

}

