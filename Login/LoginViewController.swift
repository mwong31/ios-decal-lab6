//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    var titleText = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 100))

    var main = UIView(frame: CGRect(x: 15, y: 300, width: UIScreen.main.bounds.width - 30, height: 190))

    var email = UITextField(frame: CGRect(x: 25, y: 320, width: UIScreen.main.bounds.width - 50, height: 40))
    
    var password = UITextField(frame: CGRect(x: 25, y: 375, width: UIScreen.main.bounds.width - 50, height: 40))
    
    var button = UIButton(frame: CGRect(x: 80, y: 430, width: UIScreen.main.bounds.width - 160, height: 40))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
      
        titleText.text = "Login View Controller"
        titleText.font = UIFont(name: "Avenir", size: 30)
        titleText.numberOfLines = 2
        titleText.textColor = UIColor.white
        titleText.textAlignment = .center
        view.addSubview(titleText)
        
        main.backgroundColor = UIColor.white
        main.layer.cornerRadius = 10
        view.addSubview(main)
        
        email.text = "berkeley.edu Account"
        email.font = UIFont(name: "Avenir", size: 20)
        email.textAlignment = .center
        email.textColor = UIColor.gray
        view.addSubview(email)
        
        password.text = "Password"
        password.font = UIFont(name: "Avenir", size: 20)
        password.textAlignment = .center
        password.textColor = UIColor.gray
        view.addSubview(password)
        
        button.setTitle("Login", for: .normal)
        button.backgroundColor = Constants.backgroundColor
        button.titleLabel!.font = UIFont(name: "Avenir", size: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action:#selector(loginButton), for:.touchUpInside)

        view.addSubview(button)
        
        // TODO: layout your views using frames or AutoLayout
        
    }
    
    // TODO: create an IBAction for your login button
    
    @IBAction func loginButton(sender: UIButton) {
        authenticateUser(username: email.text!.lowercased(), password: password.text)
    }

    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
