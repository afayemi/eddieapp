//
//  StudentSearchViewController.swift
//  EddieApp
//
//  Created by YungGoku on 12/29/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StudentSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var students = [NSDictionary]()
    var filteredStudents = [NSDictionary]()
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Student Search"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        ref.child("users").queryOrdered(byChild: "username").observe(.childAdded, with: { (snapshot) in
            
            self.students.append((snapshot.value as? NSDictionary)!)
            
            //insert the rows
            
            self.tableview.insertRows(at: [IndexPath(row: self.students.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            
            return filteredStudents.count
        } else {
            
            return self.students.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "studentSearchCell", for: indexPath) as! StudentSearchTableViewCell
        
        let user : NSDictionary?
        
        if searchController.isActive && searchBar.text == "" {
            
            user = filteredStudents[indexPath.row]
            
        } else {
            user = self.students[indexPath.row]
            
        }
        
        cell.usernameLabel.text = user!["username"] as? String
        cell.schoolNameLabel.text = user!["schoolName"] as? String

        return cell
    }
    
    func updateSearchResults(_ searchController: UISearchController){
        
        print("We are close")
        filterContent(searchText: self.searchController.searchBar.text!)
        
    }
    
    func filterContent(searchText: String){
        
        self.filteredStudents = self.students.filter({ (user) -> Bool in
            
            let username = user["username"] as? String
            
            //print(username)
            
            return(username?.lowercased().contains(searchText.lowercased()))!
            
        })
        
        self.tableview.reloadData()
        
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
