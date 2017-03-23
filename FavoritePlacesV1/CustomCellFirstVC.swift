//
//  CustomCellFirstVC.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 23.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit

class CustomCellFirstVC: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
