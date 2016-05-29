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
    
    @IBOutlet weak var networkActivityIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    var superQueryViewModel: SuperQueryViewModel!
    let cellIdentifier = String(SuperTableViewCell)
    
    let activityIndicator = ActivityIndicator()
    
    var latestQuery: Observable<String> {
        return searchTextField
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count > 0 }
            .distinctUntilChanged()
    }
    
    convenience init() {
        self.init(nibName: "BaseViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let superCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(superCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        setupRx()
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
        
        // Displays an activity indicator in the middle of the search bar.
        // TODO: Refactor to use PKHUD (or similar).
        superQueryViewModel.activityIndicator
            .drive(networkActivityIndicator.rx_animating)
            .addDisposableTo(disposeBag)
        
        // Displays network activity indicator in upper right hand corner
        // TODO: Use full size activity indicator / HUD
        //superQueryViewModel.activityIndicator
            //.drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            //.addDisposableTo(disposeBag)
        
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

}
