//
//  FavouriteButton.swift
//  Weather Or Not
//
//  Created by James Frost on 26/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class FavouriteButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.blue.cgColor
    }
}
