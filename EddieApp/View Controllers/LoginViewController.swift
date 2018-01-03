//
//  LoginViewController.swift
//  EddieApp
//
//  Created by YungGoku on 11/16/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        handleTextField()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
       if Auth.auth().currentUser != nil {
              self.performSegue(withIdentifier: "signinToTabHome", sender: nil)
       }
    }
    
    @IBAction func signinButtonClick(_ sender: Any) {
        
        
        //Signs In Registered User
        AuthService.signin(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            
            print("On Success")
            self.performSegue(withIdentifier: "signinToTabHome", sender: nil)

        }, onError: { error in
            print(error!)
            
        })
        
        
        //Performs Segue to HomeViewController
    }
    
    
    func handleTextField(){

        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange(){
        
        guard let email = emailTextField.text, !email.isEmpty, let pswd = passwordTextField.text, !pswd.isEmpty else {
            
            signinButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signinButton.isEnabled = false
            return
        }
        
        signinButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signinButton.isEnabled = true
        return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
