//
//  LoginController.swift
//  LoginController
//
//  Created by GCCISAdmin on 11/20/21.
//

import UIKit

class LoginController: UIViewController {
    
    //Parent scrollview
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //View for the Golisano logo image
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "pc")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    //Email Textfield
    private let email: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email"
        
        //This moves the text slightly away from the left edge of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    //Password Textfield
    private let password: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        
        //This moves the text slightly away from the left edge of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        //Turns the text into asterisks
        field.isSecureTextEntry = true
        
        return field
    }()
    
    //Login button
    private let loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        //Adds a buttons that goes to the Register account screen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerClicked))
        
        
        loginButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        
        email.delegate = self
        password.delegate = self
        
        //Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(email)
        scrollView.addSubview(password)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        let frameWidth = scrollView.width - 60
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        
        email.frame = CGRect(x: 30, y: imageView.bottom+10, width: frameWidth, height: 52)
        password.frame = CGRect(x: 30, y: email.bottom+10, width: frameWidth, height: 52)
        
        loginButton.frame = CGRect(x: 30, y: password.bottom+10, width: frameWidth, height: 52)
    }
    
    //Function for clicking the login button
    @objc private func loginClicked(){
        
        //Dismisses the keyboard if the focus is on the email/password fields
        email.resignFirstResponder()
        password.resignFirstResponder()
        
        guard let emailField = email.text, let passwordField = password.text, !emailField.isEmpty, !passwordField.isEmpty, passwordField.count >= 6 else {
                loginAlert()
                return
        }
        
        //Firebase Login
        
    }
    
    //Pops up an alert if there isn't valid login info
    func loginAlert(){
        let alert = UIAlertController(title: "Error", message: "Please enter appropriate login information.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    //Brings you to the register account screen
    @objc private func registerClicked(){
        let regC = RegisterController()
        
        regC.title = "Create Account"
        
        navigationController?.pushViewController(regC, animated: true)
    }


}

//Makes sure both fields are populated
extension LoginController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email {
            password.becomeFirstResponder()
        } else if textField == password{
            loginClicked()
        }
        
        return true
    }
}
