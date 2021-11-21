//
//  RegisterController.swift
//  RegisterController
//
//  Created by GCCISAdmin on 11/20/21.
//

import UIKit

class RegisterController: UIViewController {
    
    //Parent scrollview
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //View for the profile pic image
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    //Firstname Textfield
    private let firstName: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        
        //This moves the text slightly away from the left edge of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    //Lastname Textfield
    private let lastName: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        
        //This moves the text slightly away from the left edge of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
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
    private let registerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
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
        
        
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        
        email.delegate = self
        password.delegate = self
        
        //Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstName)
        scrollView.addSubview(lastName)
        scrollView.addSubview(email)
        scrollView.addSubview(password)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        let frameWidth = scrollView.width - 60
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        
        firstName.frame = CGRect(x: 30, y: imageView.bottom+10, width: frameWidth, height: 52)
        lastName.frame = CGRect(x: 30, y: firstName.bottom+10, width: frameWidth, height: 52)
        
        email.frame = CGRect(x: 30, y: lastName.bottom+10, width: frameWidth, height: 52)
        password.frame = CGRect(x: 30, y: email.bottom+10, width: frameWidth, height: 52)
        
        registerButton.frame = CGRect(x: 30, y: password.bottom+10, width: frameWidth, height: 52)
    }
    
    @objc private func changeProfilePicture(){
        print("change pic")
    }
    
    //Function for clicking the Register button
    @objc private func registerClicked(){
        
        //Dismisses the keyboard
        email.resignFirstResponder()
        password.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        
        guard let firstNameField = firstName.text,
                let lastNameField = lastName.text,
                let emailField = email.text,
                let passwordField = password.text,
                !emailField.isEmpty,
                !firstNameField.isEmpty,
                !lastNameField.isEmpty,
                !passwordField.isEmpty,
                passwordField.count >= 6 else {
                    
                    registerAlert()
                    return
        }
        
        //Firebase Login
        
    }
    
    //Pops up an alert if there isn't valid registration info
    func registerAlert(){
        let alert = UIAlertController(title: "Error", message: "Please enter appropriate registration information.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

extension RegisterController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email {
            password.becomeFirstResponder()
        } else if textField == password{
            registerClicked()
        }
        
        return true
    }
}

extension RegisterController: UIImagePickerControllerDelegate{
    
    func presentPhotoSheet(){
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        <#code#>
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        <#code#>
//    }
}
