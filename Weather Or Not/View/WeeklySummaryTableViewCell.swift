//
//  WeeklySummaryTableViewCell.swift
//  Weather Or Not
//
//  Created by James Frost on 15/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class WeeklySummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
