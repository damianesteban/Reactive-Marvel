//
//  SuperTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Nuke

class CharacterTableViewCell: UITableViewCell {
    
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
        characterImageRequestWithNuke(characterModel.imageURLString)
        characterNameLabel.text = "Name: \(characterModel.name)"
        characterDescriptionLabel.text = characterModel.description.isEmpty ? "Description: No description." : "Description: \(characterModel.description)"
    }
    
    func characterImageRequestWithNuke(urlString: String) {
        var request = ImageRequest(URLRequest: NSURLRequest(URL: NSURL(string: urlString)!))
        // Set target size (in pixels) and content mode that describe how to resize loaded image
        request.targetSize = CGSize(width: 84.0, height: 79.0)
        request.contentMode = .AspectFit
        
        
        
        // Control memory caching
        request.memoryCacheStorageAllowed = true // true is default
        request.memoryCachePolicy = .ReloadIgnoringCachedImage // Force reload
        
        // Change the priority of the underlying NSURLSessionTask
        request.priority = NSURLSessionTaskPriorityHigh
        
        Nuke.taskWith(request) {
            // - Image is resized to fill target size
            // - Blur filter is applied
            let image = $0.image
            self.characterImageView.image = image
        }.resume()
    }
    
}
