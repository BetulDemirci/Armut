//
//  ViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 3.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//


import UIKit

struct KeychainConfiguration {
  static let serviceName = "TouchMe"
  static let accessGroup: String? = nil
}

extension LoginViewController{
    func hideKeyboard(){
       let tap:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
class LoginViewController: UIViewController {

    let touchMe = BiometricIDAuth()
       let emailTextField: UITextField = {
           let e = UITextField()
           
           let attributedPlaceholder = NSAttributedString(string: "email", attributes:
               [NSAttributedString.Key.foregroundColor : UIColor.white])
           e.textColor = .white
           e.attributedPlaceholder = attributedPlaceholder
           e.setBottomBorder(backGroundColor: .black, borderColor: .white)
           return e
       }()
       
       let passwordTextField: UITextField = {
           let p = UITextField()
           let attributedPlaceholder = NSAttributedString(string: "password", attributes:
               [NSAttributedString.Key.foregroundColor : UIColor.white])
           p.textColor = .white
           p.isSecureTextEntry = true
           p.attributedPlaceholder = attributedPlaceholder
           p.setBottomBorder(backGroundColor: .black, borderColor: .white)
           return p
       }()
       
       let loginButton: UIButton = {
           let l = UIButton(type: .system)
           l.setTitleColor(.white, for: .normal)
           l.setTitle("Log In", for: .normal)
           l.layer.cornerRadius = 10
           l.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.4470588235, blue: 0.1764705882, alpha: 1)
           l.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
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
       
       let touchIDButton: UIButton = {
           let f = UIButton(type: .system)
           f.setTitleColor(.white, for: .normal)
           f.backgroundColor = .black
           f.isEnabled = false
           f.addTarget(self, action: #selector(touchIDLoginAction), for: .touchUpInside)
           return f
       }()
       
       
       let haveAccountButton: UIButton = {
           let color = #colorLiteral(red: 0.9137254902, green: 0.4470588235, blue: 0.1764705882, alpha: 1)
           let font = UIFont.systemFont(ofSize: 16)
           
           let h = UIButton(type: .system)
           h.backgroundColor = .black
           let attributedTitle = NSMutableAttributedString(string:
               "Don't have an account? ", attributes: [NSAttributedString.Key.foregroundColor:
                   color, NSAttributedString.Key.font : font ])
           
           attributedTitle.append(NSAttributedString(string: "Sign Up", attributes:
               [NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font]))
           
           h.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
           h.setAttributedTitle(attributedTitle, for: .normal)
           return h
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .black
       
       emailTextField.delegate = self as? UITextFieldDelegate
       passwordTextField.delegate = self as? UITextFieldDelegate
       
       navigationController?.isNavigationBarHidden = true
       
       setupAddLogo()
       setupTextFieldComponents()
       setupLoginButton()
       setupHaveAccountButton()
       setupTouchIdButton()
       
       
       
       if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
         emailTextField.text = storedUsername
           
           touchIDButton.isHidden = !touchMe.canEvaluatePolicy()
           
           switch touchMe.biometricType() {
           case .faceID:
             touchIDButton.setImage(UIImage(named: "FaceIcon"),  for: .normal)
           default:
             touchIDButton.setImage(UIImage(named: "Touch-icon-lg"),  for: .normal)
           }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
         if hasLogin{
            let touchBool = touchMe.canEvaluatePolicy()
                if touchBool {
                   self.touchIDLoginAction()
               }
           }
       }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func signupAction() {
        let pageViewController = self.parent as! PageViewController
        pageViewController.nextPageWithIndex(index: 0)
    }
    @objc func loginAction() {
         guard let newAccountName = emailTextField.text,
              let newPassword = passwordTextField.text,
              !newAccountName.isEmpty,
              !newPassword.isEmpty else {
                showLoginFailedAlert()
                return
            }
         
         emailTextField.resignFirstResponder()
         passwordTextField.resignFirstResponder()
         
         if checkLogin(username: newAccountName, password: newPassword) {
             
         
         self.performSegue(withIdentifier: "loginToHome", sender: self)
         let logIn: UserDefaults? = UserDefaults.standard
         logIn?.set(true, forKey: "isUserLoggedIn")
         
         } else {
           showLoginFailedAlert()
         }
     }
     
     @objc func touchIDLoginAction() {
         touchMe.authenticateUser() { [weak self] message in
              if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
              } else {
                let logIn: UserDefaults? = UserDefaults.standard
                 logIn?.set(true, forKey: "isUserLoggedIn")
                self!.performSegue(withIdentifier: "loginToHome", sender: self)
              }
            }
     }
     
     fileprivate func setupAddLogo() {
         view.addSubview(logo)
         logo.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 52, bottom: nil,
                      bottomPad: 0, left: nil, leftPad: 0, right: nil, rightPad: 0,
                      height: 218, width: 218)
         logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     }
     
     fileprivate func setupTextFieldComponents() {
         setupEmailField()
         setupPasswordField()
     }
     
     fileprivate func setupEmailField() {
         view.addSubview(emailTextField)
         
         emailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0,
                                left: view.leftAnchor, leftPad: 24, right: view.rightAnchor,
                                rightPad: 24, height: 30, width: 0)
         emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     }
     
     fileprivate func setupPasswordField() {
         view.addSubview(passwordTextField)
         
         passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil,
                                   bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0,
                                   right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
     }
     
     fileprivate func setupLoginButton() {
         view.addSubview(loginButton)
         
         loginButton.anchors(top: passwordTextField.bottomAnchor, topPad: 12, bottom: nil,
                             bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0,
                             right: passwordTextField.rightAnchor, rightPad: 0, height: 50, width: 0)
     }
     
     fileprivate func setupTouchIdButton() {
         
            view.addSubview(touchIDButton)
            touchIDButton.anchors(top: loginButton.bottomAnchor, topPad: 22, bottom: nil,
                         bottomPad: 0, left: nil, leftPad: 0, right: nil, rightPad: 0,
                         height: 68, width: 66)
            touchIDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
     
    
     fileprivate func setupHaveAccountButton() {
         view.addSubview(haveAccountButton)
         
         haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   bottomPad: 8, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor,
                                   rightPad: 12, height: 30, width: 0)
     }
     
     func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
          return false
        }
        
        do {
          let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                  account: username,
                                                  accessGroup: KeychainConfiguration.accessGroup)
          let keychainPassword = try passwordItem.readPassword()
          return password == keychainPassword
        }
        catch {
          fatalError("Error reading password from keychain - \(error)")
        }
        return false
      }
     
     private func showLoginFailedAlert() {
       let alertView = UIAlertController(title: "Login Problem",
                                         message: "Wrong username or password.",
                                         preferredStyle:. alert)
       let okAction = UIAlertAction(title: "Foiled Again!", style: .default)
       alertView.addAction(okAction)
       present(alertView, animated: true)
     }
}

