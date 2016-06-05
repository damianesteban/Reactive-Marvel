//
//  SuperTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Kingfisher

class SuperTableViewCell: UITableViewCell {

    
    @IBOutlet weak var superImageView: UIImageView!
    @IBOutlet weak var superNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with superModel: CharacterModel) {
        superImageView.kf_setImageWithURL(NSURL(string: superModel.imageURLString)!,
                                     placeholderImage: nil,
                                     optionsInfo: [.Transition(ImageTransition.Fade(1))])
        superNameLabel.text = superModel.name
    }
    
}
