//
//  HomeViewController.swift
//  EddieApp
//
//  Created by YungGoku on 12/22/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableview: UITableView!
    
    
    var schools = [School]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        
        loadSchools()

        // Do any additional setup after loading the view.
    }
    
    func loadSchools(){
        Database.database().reference().child("schools").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let name = dict["schoolName"] as! String
                let address = dict["schoolAddress"] as! String
                let city = dict["schoolCity"] as! String
                let zipcode = dict["schoolZipcode"] as! String
                let school = School(name: name, address: address, city: city, zipcode: zipcode)
                self.schools.append(school)
                
                self.tableview.reloadData()
            }
        }
    }
    
    //THE NEXT THING WE DO
    //IS WE NEED TO ALLOW PHOTOGRAPHRERS TO TAKE/UPLOAD PIC
    //THEN EITHER ADD IT TO EXISTING USERS PHOTO SPACE
    //OR CREATE NEW USER AND ADD PHOTO TO THEIR PHOTO SPACE
    //THEN FOR STUDENTS, ALL THEM TO SEE THEIR PICTURES
    //CLICK THE PICTURE TO BE DIRECTED TO A BUY PICTURE PAGE
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as! SchoolTableViewCell
        let school = schools[indexPath.row]
        //cell.textLabel?.text = schools[indexPath.row].name
        cell.schoolName?.text = school.name
        cell.schoolAddress?.text = school.address
//        let ref = Database.database().reference().child("users").
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toStudentSearchScreen(_ sender: Any) {
        
        performSegue(withIdentifier: "schoolToStudentSearch", sender: nil)
        
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
