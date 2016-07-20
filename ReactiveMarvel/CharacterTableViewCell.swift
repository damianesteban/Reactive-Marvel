//
//  SuperTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Nuke

class CharacterTableViewCell: UITableViewCell, Nukeable {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with characterModel: CharacterModel) {
        imageRequestWithNuke(characterModel.imageURLString, imageView: characterImageView, size: CGSizeMake(84.0, 79.0))
        characterNameLabel.text = "Name: \(characterModel.name)"
        characterDescriptionLabel.text = characterModel.description.isEmpty ? "Description: No description." : "Description: \(characterModel.description)"
    }
    
    func imageRequestWithNuke(urlString: String, imageView: UIImageView, size: CGSize) {
        let request = ImageRequest(URL: NSURL(string: urlString)!, targetSize: size, contentMode: .AspectFit)
        
        Nuke.taskWith(request) {
            let image = $0.image
            imageView.image = image
        }.resume()
    }
    
}
