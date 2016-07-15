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
    
    var characterModel: CharacterModel!
    
    var characterId: BehaviorSubject<String> {
        return BehaviorSubject<String>(value: characterModel!.id)
    }
    
    let disposeBag = DisposeBag()
    var characterDetailViewModel: CharactersDetailViewModel!
    let cellIdentifier = String(CharacterDetailTableViewCell)
    
    convenience init() {
        self.init(nibName: "CharacterDetailViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let characterDetailCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(characterDetailCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 50
        startRx()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRx() {
        characterDetailViewModel = CharactersDetailViewModel(characterId: characterId)
        
        characterDetailViewModel
            .trackComics()
            .bindTo(tableView.rx_itemsWithCellIdentifier(cellIdentifier, cellType: CharacterDetailTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
            }.addDisposableTo(disposeBag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
