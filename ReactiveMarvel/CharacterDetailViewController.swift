//
//  CharacterDetailViewController.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/1/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Haneke

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterDetailImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterdescriptionLabel: UILabel!
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let disposeBag = DisposeBag()
    var characterDetailViewModel: CharacterDetailViewModel!
    var model: CharacterModel?
    
    convenience init() {
        self.init(nibName: "CharacterDetailViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = model {
            print(model)
            characterDetailImageView.hnk_setImageFromURL(NSURL(string: model.imageURLString)!)
            characterNameLabel.text = model.name
            characterdescriptionLabel.text = model.description
        }

    }
    
    func setupRx() {
        // TODO: Figure out a better way to handle this.  Sloppy.
        //characterDetailViewModel = CharacterDetailViewModel(withCollectionURIObservable: model?.comicsCollectionURIString.asObservable())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
