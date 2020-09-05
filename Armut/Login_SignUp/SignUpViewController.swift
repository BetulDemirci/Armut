//
//  SignUpViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 3.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//


import UIKit

class SignUpViewController: UIViewController {

    let NameSurnameTextField: UITextField = {
           let n = UITextField()
           
           let attributedPlaceholder = NSAttributedString(string: "Name Surname", attributes:
               [NSAttributedString.Key.foregroundColor : UIColor.white])
           n.textColor = .white
           n.attributedPlaceholder = attributedPlaceholder
           n.setBottomBorder(backGroundColor: .black, borderColor: .white)
           return n
       }()
       
       let emailTextField: UITextField = {
           let e = UITextField()
           
           let attributedPlaceholder = NSAttributedString(string: "Email", attributes:
               [NSAttributedString.Key.foregroundColor : UIColor.white])
           e.textColor = .white
           e.attributedPlaceholder = attributedPlaceholder
           e.setBottomBorder(backGroundColor: .black, borderColor: .white)
           return e
       }()
       
       
       let passwordTextField: UITextField = {
           let p = UITextField()
           let attributedPlaceholder = NSAttributedString(string: "Password", attributes:
               [NSAttributedString.Key.foregroundColor : UIColor.white])
           p.textColor = .white
           p.isSecureTextEntry = true
           p.attributedPlaceholder = attributedPlaceholder
           p.setBottomBorder(backGroundColor: .black, borderColor: .white)
           return p
       }()
       
       let signUpButton: UIButton = {
           let l = UIButton(type: .system)
           l.setTitleColor(.white, for: .normal)
           l.setTitle("Sign In", for: .normal)
           l.layer.cornerRadius = 10
           l.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.4470588235, blue: 0.1764705882, alpha: 1)
           l.addTarget(self, action: #selector(createUser), for: .touchUpInside)
           return l
       }()
       
       let logo: UIImageView = {
           let imageName =  "logo-armut.png"
           let image = UIImage(named: imageName)
           let l = UIImageView(image: image!)
           l.contentMode = .scaleAspectFill
           l.layer.masksToBounds = true
           l.layer.cornerRadius = 20
           return l
       }()
       
       let haveAccountButton: UIButton = {
           let color = #colorLiteral(red: 0.9137254902, green: 0.4470588235, blue: 0.1764705882, alpha: 1)
           let font = UIFont.systemFont(ofSize: 16)
           
           let h = UIButton(type: .system)
           h.backgroundColor = .black
           let attributedTitle = NSMutableAttributedString(string:
               "Already have an account? ", attributes: [NSAttributedString.Key.foregroundColor:
                   color, NSAttributedString.Key.font : font ])
           
           attributedTitle.append(NSAttributedString(string: "Sign In", attributes:
               [NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font]))
           
           h.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
           h.setAttributedTitle(attributedTitle, for: .normal)
           return h
       }()
       
    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = .black
               
           emailTextField.delegate = self as? UITextFieldDelegate
           passwordTextField.delegate = self as? UITextFieldDelegate
           NameSurnameTextField.delegate = self as? UITextFieldDelegate
           navigationController?.isNavigationBarHidden = true
           
           setupAddLogo()
           setupTextFieldComponents()
           setupSignUpButton()
           setupHaveAccountButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
       fileprivate func setupTextFieldComponents() {
           setUpNameSurnameField()
           setupEmailField()
           setupPasswordField()
       }
       
       fileprivate func setUpNameSurnameField() {
              view.addSubview(NameSurnameTextField)
              
              NameSurnameTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0,
                                     left: view.leftAnchor, leftPad: 24, right: view.rightAnchor,
                                     rightPad: 24, height: 30, width: 0)
              NameSurnameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
          }
          
          
          fileprivate func setupEmailField() {
              view.addSubview(emailTextField)
              
              emailTextField.anchors(top: NameSurnameTextField.bottomAnchor, topPad: 8, bottom: nil,
                                        bottomPad: 0, left: NameSurnameTextField.leftAnchor, leftPad: 0,
                                        right: NameSurnameTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
            
            
             
          }
       
          fileprivate func setupPasswordField() {
              view.addSubview(passwordTextField)
              
              passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil,
                                        bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0,
                                        right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
          }
       
       fileprivate func setupSignUpButton() {
           view.addSubview(signUpButton)
           
           signUpButton.anchors(top: passwordTextField.bottomAnchor, topPad: 12, bottom: nil,
                               bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0,
                               right: passwordTextField.rightAnchor, rightPad: 0, height: 50, width: 0)
       }
       fileprivate func setupAddLogo() {
           view.addSubview(logo)
           logo.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 52, bottom: nil,
                        bottomPad: 0, left: nil, leftPad: 0, right: nil, rightPad: 0,
                        height: 218, width: 218)
           logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       }
       
       fileprivate func setupHaveAccountButton() {
              view.addSubview(haveAccountButton)
              
              haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        bottomPad: 8, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor,
                                        rightPad: 0, height: 20, width: 0)
              
          }
       
       @objc func signInAction() {
          let pageViewController = self.parent as! PageViewController
         pageViewController.nextPageWithIndex(index: 2)
       }
       
       @objc(User) func createUser(){
           guard let newAccountName = emailTextField.text,
             let newPassword = passwordTextField.text,
             !newAccountName.isEmpty,
             !newPassword.isEmpty else {
               showLoginFailedAlert()
               return
           }
           
           let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
           if !hasLoginKey && emailTextField.hasText {
             UserDefaults.standard.setValue(emailTextField.text, forKey: "username")
               do {
                 
                 // This is a new account, create a new keychain item with the account name.
                 let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                         account: newAccountName,
                                                         accessGroup: KeychainConfiguration.accessGroup)
                 
                 // Save the password for the new item.
                 try passwordItem.savePassword(newPassword)
               } catch {
                 fatalError("Error updating keychain - \(error)")
               }
                UserDefaults.standard.set(true, forKey: "hasLoginKey")
               let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "sbLogin") as! LoginViewController
               storyBoard.modalPresentationStyle = .fullScreen
               self.present(storyBoard, animated: true, completion: nil)
           }
           else if hasLoginKey{
               let alertView = UIAlertController(title: "Warning!",
                                                 message: "Your registration has already taken place. Please try to login using face id or touch id.",
                                                 preferredStyle:. alert)
               let okAction = UIAlertAction(title: "Try Again!", style: .default)
               alertView.addAction(okAction)
               present(alertView, animated: true)
           }
       }
      private func showLoginFailedAlert() {
         let alertView = UIAlertController(title: "Sign up Problem",
                                           message: "Wrong username or password.",
                                           preferredStyle:. alert)
         let okAction = UIAlertAction(title: "Foiled Again!", style: .default)
         alertView.addAction(okAction)
         present(alertView, animated: true)
       }

}
extension UITextField {
    
    func setBottomBorder(backGroundColor: UIColor, borderColor: UIColor) {
        self.layer.backgroundColor = backGroundColor.cgColor
        
        // defines the layers shadow
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = borderColor.cgColor
    }
}
extension SignUpViewController{
    func hideKeyboard(){
       let tap:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension UIView {
    func anchors(top: NSLayoutYAxisAnchor?, topPad: CGFloat, bottom: NSLayoutYAxisAnchor?, bottomPad: CGFloat,
                 left: NSLayoutXAxisAnchor?, leftPad: CGFloat, right: NSLayoutXAxisAnchor?, rightPad: CGFloat,
                 height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPad).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPad).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPad).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPad).isActive = true
        }
        
        if height > 0 { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
        if width > 0 { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
    }
}
