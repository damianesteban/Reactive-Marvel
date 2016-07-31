//
//  CharacterDetailViewController.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var characterModel: CharacterModel!
    var characterDetailViewModel: CharactersDetailViewModel!
    
    var characterId: BehaviorSubject<String> {
        return BehaviorSubject<String>(value: characterModel!.id)
    }
    
    let disposeBag = DisposeBag()
    let cellIdentifier = String(CharacterDetailTableViewCell)
    
    convenience init() {
        self.init(nibName: "CharacterDetailViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = characterModel.name
        self.navigationController!.navigationBar.topItem!.title = ""
        let characterDetailCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(characterDetailCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        startRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRx() {
        characterDetailViewModel = CharactersDetailViewModel(characterId: characterId)
        
        characterDetailViewModel
            .trackComics()
            .bindTo(tableView.rx_itemsWithCellIdentifier(cellIdentifier,
                cellType: CharacterDetailTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
        }.addDisposableTo(disposeBag)
        
        characterDetailViewModel.activityIndicator
            .drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
        
        characterDetailViewModel.activityIndicator
            .drive(activityIndicator.rx_animating)
            .addDisposableTo(disposeBag)
    }
}
