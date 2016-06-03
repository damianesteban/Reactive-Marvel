//
//  BaseViewController.swift
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
import Haneke

class BaseViewController: UIViewController {

    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkActivityIndicatorView: UIActivityIndicatorView!
    
    
    let disposeBag = DisposeBag()
    var superQueryViewModel: SuperQueryViewModel!
    let cellIdentifier = String(SuperTableViewCell)
    
    let activityIndicator = ActivityIndicator()
    
    // We use latestQuery to initialize SuperQueryViewModel.  When the user begins typing in
    // the UISearchBar this kicks off our network request.
    var latestQuery: Observable<String> {
        return searchTextField
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count > 1 }
            .distinctUntilChanged()
    }
    
    convenience init() {
        self.init(nibName: "BaseViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reactive Marvel"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks,
                                                            target: self, action: #selector(addTapped))
        let superCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(superCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 150
        searchTextField.placeholder = "Search for a Marvel Character..."
        setupRx()
        configureRowClicked()   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRx() {
        superQueryViewModel = SuperQueryViewModel(query: latestQuery)
        
        // Binds the Super model to the cell.
        // TODO: Refactor cell to use ViewModel.
        superQueryViewModel
            .trackSupers()
            .bindTo(tableView.rx_itemsWithCellIdentifier(cellIdentifier, cellType: SuperTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
        }.addDisposableTo(disposeBag)
        
        // Displays network activity indicator in upper left hand corner
        // TODO: Use full size activity indicator / HUD
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
    }
    
    func configureRowClicked() {
        tableView.rx_modelSelected(Super.self)
            .asDriver()
            .driveNext { model in
                let cdvc = CharacterDetailViewController()
                cdvc.model = model
                AppRouter.presentDetailViewController(from: self, toViewController: cdvc)
            }.addDisposableTo(disposeBag)
        
    }
    func addTapped() {
        print("Someone tapped me")
    }

}
