//
//  CharacterDetailViewModel.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 6/4/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

struct CharacterDetailViewModel {
    
    lazy var rx_comics: Driver<[Comic]> = self.fetchComics()
    private var comicsCollectionURIString: Observable<String>
    
    init(withCollectionURIObservable collectionURIObservable: Observable<String>) {
        self.comicsCollectionURIString = collectionURIObservable
    }
    
    // Driver is a Variable thast is on the main thread.  Convenient for binding.
    private func fetchComics() -> Driver<[Comic]> {
        return comicsCollectionURIString
            .flatMapLatest { text in
                return MarvelAPIProvider.request(.Comics(text))
                .debug()
                .catchError { error in
                    return Observable.never()
                }
            }
            .map { json in
                return Comic.arrayFromJSON(json)

            }
            .asDriver(onErrorJustReturn: [])
    }
}