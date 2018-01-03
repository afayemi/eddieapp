//
//  SchoolSelectViewController.swift
//  EddieApp
//
//  Created by YungGoku on 12/11/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class SchoolSelectViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tabelView: UITableView!
    var schools = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        
        loadSchools()
//        var school = School(name: "Test", address: "Test", city: "Test", zipcode: "Test")

        // Do any additional setup after loading the view.
        //let databaseRef = Database.database().reference().child("schools")
        
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
                
                self.tabelView.reloadData()
                
            }
            
        }
        
    }
    
    @IBAction func schoolSelectButton(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as! SchoolTableViewCell
        let school = schools[indexPath.row]
        cell.schoolName.text = school.name
        cell.schoolAddress.text = school.address
        return cell
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
