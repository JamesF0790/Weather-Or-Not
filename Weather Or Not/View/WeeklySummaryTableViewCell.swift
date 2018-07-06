//
//  WeeklySummaryTableViewCell.swift
//  Weather Or Not
//
//  Created by James Frost on 15/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

protocol WeeklySummaryCellDelegate {
    func favouriteTapped(sender: WeeklySummaryTableViewCell)
}
class WeeklySummaryTableViewCell: UITableViewCell {

    var delegate: WeeklySummaryCellDelegate?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!

    @IBAction func favouriteButtonTapped(_ sender: FavouriteButton) {
        delegate?.favouriteTapped(sender: self)
    }
}
