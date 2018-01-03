//
//  SigninViewController.swift
//  EddieApp
//
//  Created by YungGoku on 11/16/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import Photos
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var reenterTextField: UITextField!
    @IBOutlet var signupbttn: UIButton!
    
    var selectedImage: UIImage?
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var profilePic: UIImageView!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({
            (newStatus) in print("status is \(newStatus)")
            if newStatus == PHAuthorizationStatus.authorized {
        
                print("success")
                
            }
        })
        case .restricted: print("User do not have access to photo album.")
        case .denied: print("User has denied the permission.")
        }
    }
    
    override func viewDidLoad() {
        
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        checkPermission()
        
        let uploadProfilePic = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.selectProfileImageView))
            
        profilePic.addGestureRecognizer(uploadProfilePic)
        
        profilePic.isUserInteractionEnabled = true
        
        handleTextField()
    }
    
    func handleTextField(){
        
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange(){
        
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let pswd = passwordTextField.text, !pswd.isEmpty else {
            
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signUpButton.isEnabled = false
            return
        }
        
        signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signUpButton.isEnabled = true
        return
    }
    
    @objc func selectProfileImageView() {
        
        print("Tapped!")
        
        //Show Photo Picker
        let pickerController = UIImagePickerController() as UIImagePickerController
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("This Image Picking Controller Method DiD Something")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImage = image
            profilePic.image = image
            
        }
        print("INFO INFORMATION LOL: " + info.description)
        
        dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBttnClick(_ sender: Any) {
    
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.2) {
            
            AuthService.signup(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                self.performSegue(withIdentifier: "signupToTabHome", sender: nil)
            }, onError: { (error) in
                print(error)
            })
            
        }
                
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
