//
//  AddSchoolsViewController.swift
//  EddieApp
//
//  Created by YungGoku on 12/14/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class AddSchoolsViewController: UIViewController {

    @IBOutlet var schoolTextField: UITextField!
    @IBOutlet var streetAddressTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var zipcodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func submitSchoolButton(_ sender: Any) {
        print("You are almost.....")
        
        let schoolID = NSUUID().uuidString
        sendDataToDatabase(schoolName: schoolTextField.text!, schoolAddress: streetAddressTextField.text!, schoolCity: zipcodeTextField.text!, schoolZipCode: zipcodeTextField.text!, schoolId: schoolID)
        
        print("DONE!")
    }
    
    func sendDataToDatabase(schoolName: String, schoolAddress: String, schoolCity: String, schoolZipCode: String, schoolId: String){
        let schoolRef = Database.database().reference().child("schools")
        let newSchoolRef = schoolRef.child(schoolId)
        //Creates a New School with information provided.
        //Stored to database
        newSchoolRef.setValue(["schoolName": schoolName, "schoolAddress": schoolAddress, "schoolCity": schoolCity, "schoolZipcode": schoolZipCode] as NSDictionary)
        
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
