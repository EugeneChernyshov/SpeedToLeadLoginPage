//
//  ViewController.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets and properties
    
    @IBOutlet weak var emailView: ReusableTextField!
    @IBOutlet weak var passwordView: ReusableTextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let viewModel = ViewModel()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        emailView.delegate = self
        passwordView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        configureUI()
        validateFields()
    }
    
    //MARK: - Functions
    
    func configureUI() {
        emailView.configure(textFieldName: "Email",
                            keyboardType: .emailAddress,
                            isSecureTextEntry: false,
                            placeholder: "Email",
                            buttonImage: UIImage(systemName: "multiply"))
        
        passwordView.configure(textFieldName: "Password",
                               keyboardType: .default,
                               isSecureTextEntry: true,
                               placeholder: "Password",
                               buttonImage: UIImage(systemName: "eye.slash.circle"))
        
        logInButton.titleLabel?.font =  UIFont(name: "Poppins", size: 17)
        configureTFActions()
    }
    
    func changeButtonState(state: ButtonState) {
        DispatchQueue.main.async {
            switch state {
            case .invalidate:
                self.logInButton.isEnabled = false
                self.logInButton.backgroundColor = UIColor(named: "grayLockButtonState")
            case .validate:
                self.logInButton.isEnabled = true
                self.logInButton.backgroundColor = UIColor(named: "redUnlockButtonState")
            }
        }
    }
    
    func validateFields() {
         if emailView.textField.isValidEmail() && passwordView.textField.text != "" {
            changeButtonState(state: .validate)
        } else {
            changeButtonState(state: .invalidate)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Incorrect Email/Password or User doesn't exist", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    func configureTFActions() {
        emailView.rightAction = { [weak self] in
            self?.emailView.clearTextField()
        }
        
        passwordView.rightAction = { [weak self] in
            self?.passwordView.showSecureText()
        }
        
        emailView.textFieldDidChange = { [weak self] in
            self?.validateFields()
        }
        
        emailView.textFieldDidChange = { [weak self] in
            self?.validateFields()
        }
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        guard let email = emailView.textField.text, let password = passwordView.textField.text else { return }
        viewModel.logIn(email: email, password: password, errorHandler: { [weak self] in
            self?.showAlert()
        })
        viewModel.navigateToUserDetailsVC(currentVC: self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        emailView.checkState()
        passwordView.checkState()
        textFieldDidEndEditing(emailView.textField)
        textFieldDidEndEditing(passwordView.textField)
    }
}

    //MARK: - Extensions (If needed)

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        validateFields()
    }
}

extension ViewController: ReusableTextFieldEditingChangedDelegate {
    func editingChanged() {
        validateFields()
    }
}
