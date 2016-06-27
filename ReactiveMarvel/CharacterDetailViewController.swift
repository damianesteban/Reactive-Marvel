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
    
    var comicsCollectionURI: BehaviorSubject<String>?
    
    let disposeBag = DisposeBag()
    
    var characterModel: CharacterModel? {
        didSet {
            comicsCollectionURI = BehaviorSubject<String>(value: characterModel!.comicsCollectionURIString)
            comicsCollectionURI!.subscribeNext { uri in
                    print(uri)
            }.addDisposableTo(disposeBag)
        }
    }

    convenience init() {
        self.init(nibName: "CharacterDetailViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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