//
//  FavouriteCell.swift
//  What
//
//  Created by Will on 12/18/17.
//  Copyright © 2017 Will. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var FavouriteImage: UIImageView!
    
    @IBOutlet weak var FavouriteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
