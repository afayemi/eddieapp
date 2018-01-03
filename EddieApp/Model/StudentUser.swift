//
//  StudentUser.swift
//  EddieApp
//
//  Created by YungGoku on 12/29/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import Foundation

class StudentUser {
    
    let username: String
    let school: School
    let photos: [String]
    
    
    init(username: String, school: School, photos: [String]){
        
        self.username = username
        self.school = school
        self.photos = photos
        
    }
    
}
