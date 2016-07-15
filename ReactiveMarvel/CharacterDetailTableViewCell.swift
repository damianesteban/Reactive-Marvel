//
//  CharacterDetailTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 7/15/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicIssueNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with comicModel: Comic) {
        comicTitleLabel.text = comicModel.title
        comicIssueNumberLabel.text = String(comicModel.issueNumber)
    }
    
}
