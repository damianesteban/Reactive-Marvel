//
//  CharacterDetailTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 7/15/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Nuke

class CharacterDetailTableViewCell: UITableViewCell, Nukeable {

    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var seriesDescriptionLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with comicModel: Comic) {
        imageRequestWithNuke(comicModel.imageURLString, imageView: comicImageView, size: CGSizeMake(80.0, 86.0))
        comicTitleLabel.text = comicModel.title
        seriesDescriptionLabel.text = comicModel.description.isEmpty ? "No description." : comicModel.description
    }
    
    func imageRequestWithNuke(urlString: String, imageView: UIImageView, size: CGSize) {
        let request = ImageRequest(URL: NSURL(string: urlString)!, targetSize: size, contentMode: .AspectFit)
        
        Nuke.taskWith(request) {
            let image = $0.image
            imageView.image = image
        }.resume()
    }
}



