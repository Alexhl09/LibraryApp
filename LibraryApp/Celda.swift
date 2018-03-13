//
//  Celda.swift
//  LibraryApp
//
//  Created by Alejandro on 12/03/18.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import UIKit

class Celda: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var titulo: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
