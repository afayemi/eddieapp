//
//  CameraViewController.swift
//  EddieApp
//
//  Created by YungGoku on 11/25/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var shareButton: UIButton!
    @IBOutlet var captionText: UITextView!
    @IBOutlet var photo: UIImageView!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        
        // Do any additional setup after loading the view.
        
        let uploadProfilePic = UITapGestureRecognizer(target: self, action: #selector(self.photoClicked))
        photo.addGestureRecognizer(uploadProfilePic)
        photo.isUserInteractionEnabled = true
    }


    @IBAction func photoClicked(_ sender: Any) {
        //Show Photo Picker
        let pickerController = UIImagePickerController() as UIImagePickerController
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.2) {
            let photoId = NSUUID().uuidString
            let storageRef =  Storage.storage().reference()
            let childStorage = storageRef.child("posts").child(photoId)
            
            childStorage.putData(imageData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error)
                    return
                } else {
                    //Attain profile image location for Cloud Storage
                    let photoUrl = metadata?.downloadURL()?.absoluteString
                    self.sendDataToDatabase(photoURL: photoUrl!)
                    
                    self.performSegue(withIdentifier: "camToSchool", sender: nil)
                }
            })
        }
    }
    
    
    func sendDataToDatabase(photoURL: String){
        let ref = Database.database().reference()
        let postReference = ref.child("posts")
        let newPostId = postReference.childByAutoId().key
        let newPostRef = postReference.child(newPostId)
        //Creates a New User with information provided.
        //Stored to database
        newPostRef.setValue(["photoURL": photoURL, "captions": captionText.text!] as NSDictionary)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImage = image
            photo.image = image
            
        }
        print("INFO INFORMATION LOL: " + info.description)
        
        dismiss(animated: true, completion: nil)
        
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
