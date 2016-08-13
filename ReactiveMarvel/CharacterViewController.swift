//
//  CharacterViewController.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/26/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class CharacterViewController: UIViewController {

    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkActivityIndicatorView: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    let cellIdentifier = String(CharacterTableViewCell)
    let activityIndicator = ActivityIndicator()
    
    var superQueryViewModel: CharactersQueryViewModel!
    
    // We use latestQuery to initialize CharactersQueryViewModel.  When the user begins typing in
    // the UISearchBar this kicks off our network request.
    var latestQuery: Observable<String> {
        return searchTextField
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count > 1 }
            .distinctUntilChanged()
    }
    
    convenience init() {
        self.init(nibName: "CharacterViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reactive Marvel"
        self.navigationController!.navigationBar.topItem!.title = ""
        let characterCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(characterCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 25
        searchTextField.placeholder = "Search for a Marvel Character..."
        startRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRx() {
        superQueryViewModel = CharactersQueryViewModel(query: latestQuery)
        
        // Binds the CharacterModel model to the cell.
        // TODO: Refactor cell to use ViewModel.
        superQueryViewModel
            .trackCharacters()
            .bindTo(tableView.rx_itemsWithCellIdentifier(cellIdentifier, cellType: CharacterTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
        }.addDisposableTo(disposeBag)
        
        // Displays network activity indicator in upper left hand corner
        // TODO: Use PKHUD, write Rx extension
        superQueryViewModel.activityIndicator
            .drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
        
        superQueryViewModel.activityIndicator
            .drive(networkActivityIndicatorView.rx_animating)
            .addDisposableTo(disposeBag)
        
        // If the user clicks on a cell and the keyboard is visible,
        // please hide it.
        tableView
            .rx_itemSelected  // this emits a signal every time someone taps on a tableView cell.
            .subscribeNext { indexPath in
                if self.searchTextField.isFirstResponder() == true {
                    self.view.endEditing(true)
                }
            }.addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(CharacterModel)
            .subscribeNext { characterModel in
                let cdvc = CharacterDetailViewController()
                cdvc.characterModel = characterModel
                //AppRouter.presentDetailViewController(from: self, toViewController: cdvc)
                self.navigationController?.pushViewController(cdvc, animated: true)
        }.addDisposableTo(disposeBag)
    }

    func addTapped() {
        print("Someone tapped me")
    }

}
