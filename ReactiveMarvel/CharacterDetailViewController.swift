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
    
    var characterId: BehaviorSubject<String>!
    let disposeBag = DisposeBag()
    var characterDetailViewModel: CharactersDetailViewModel!
    
    var characterModel: CharacterModel? {
        didSet {
            characterId = BehaviorSubject<String>(value: characterModel!.id)
            characterDetailViewModel = CharactersDetailViewModel(characterId: characterId)
            characterDetailViewModel.trackComics()
                .subscribeNext { comic in
                    print(comic)
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
