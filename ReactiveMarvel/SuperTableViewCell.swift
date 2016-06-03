//
//  SuperTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Haneke

class SuperTableViewCell: UITableViewCell {

    
    @IBOutlet weak var superImageView: UIImageView!
    @IBOutlet weak var superNameLabel: UILabel!
    @IBOutlet weak var superDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with superModel: CharacterModel) {
        superImageView.hnk_setImageFromURL(NSURL(string: superModel.imageURLString)!)
        superNameLabel.text = superModel.name
        superDescriptionLabel.text = superModel.description
    }
    
}
