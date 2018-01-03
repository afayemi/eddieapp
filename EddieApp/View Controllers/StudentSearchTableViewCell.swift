//
//  StudentSearchTableViewCell.swift
//  EddieApp
//
//  Created by YungGoku on 12/29/17.
//  Copyright © 2017 YungGoku. All rights reserved.
//

import UIKit

class StudentSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var schoolNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
