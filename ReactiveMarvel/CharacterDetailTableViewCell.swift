//
//  CharacterDetailTableViewCell.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 7/15/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import Nuke

class CharacterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicIssueNumberLabel: UILabel!
    @IBOutlet weak var seriesNameLabel: UILabel!
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
        comicImageRequestWithNuke(comicModel.imageURLString)
        comicTitleLabel.text = comicModel.title
        comicIssueNumberLabel.text = String(comicModel.issueNumber)
        seriesNameLabel.text = comicModel.seriesName
        seriesDescriptionLabel.text = comicModel.description
    }
    
    func comicImageRequestWithNuke(urlString: String) {
        var request = ImageRequest(URLRequest: NSURLRequest(URL: NSURL(string: urlString)!))
        // Set target size (in pixels) and content mode that describe how to resize loaded image
        request.targetSize = CGSize(width: 82.0, height: 92.0)
        request.contentMode = .AspectFit
        
        // Control memory caching
        request.memoryCacheStorageAllowed = true // true is default
        request.memoryCachePolicy = .ReloadIgnoringCachedImage // Force reload
        
        // Change the priority of the underlying NSURLSessionTask
        request.priority = NSURLSessionTaskPriorityHigh
        
        Nuke.taskWith(request) {
            let image = $0.image
            self.comicImageView.image = image
        }.resume()
    }
    
}



