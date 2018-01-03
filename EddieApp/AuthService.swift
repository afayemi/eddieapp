//
//  AuthService.swift
//  EddieApp
//
//  Created by YungGoku on 12/1/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AuthService {
    
    
    static func signin(email: String, password: String, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        //Signs In Registered User
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in

            if error != nil {
                onError(error?.localizedDescription)
                
                return
            }
            onSuccess()
        }
        
        print("Auth Service Reached")
        
    }
    
    static func signup(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        //Signs In Registered User
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                print(error.debugDescription)
                return
            }
            
            let uid = user?.uid
            
            let storageRef =  Storage.storage().reference()
            let childStorage = storageRef.child("profile_image").child(uid!)
            
                childStorage.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    } else {
                        //Attain profile image location for Cloud Storage
                        let profileImageUrl = metadata?.downloadURL()?.absoluteString
                        setUserInfo(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
                        
                    }

                })
        }
    }
        
        static func signupStudent(username: String, email: String, password: String, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
            
            //Signs In Registered User
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if error != nil {
                    
                    print(error.debugDescription)
                    return
                }
                
                let uid = user?.uid
                
                setStudentInformation(username: username, email: email, uid: uid!, onSuccess: onSuccess)

            }
    }
    

        
        static func setUserInfo(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
            let ref = Database.database().reference()
            let userReference = ref.child("users")
            let newUserRef = userReference.child(uid)
            //Creates a New User with information provided.
            //Stored to database
            newUserRef.setValue(["username": username, "email": email, "profileImageURL": profileImageUrl] as NSDictionary)
            onSuccess()
        }
            
        static func setStudentInformation(username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
                let ref = Database.database().reference()
                let userReference = ref.child("studentUsers")
                let newUserRef = userReference.child(uid)
                //Creates a New User with information provided.
                //Stored to database
                newUserRef.setValue(["username": username, "email": email] as NSDictionary)
                onSuccess()
            }
            
            
            //        static func signupAdmin(username: String, email: String, password: String, isAdmin: Bool, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
            //            //Signs In Registered User
            //            if isAdmin {
            //                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            //
            //                    if error != nil {
            //
            //                        print(error.debugDescription)
            //                        return
            //                    }
            //                }
            //            }
            //        }
        
    }

