//
//  CharacterDetailViewModel.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 7/14/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import SwiftyJSON
import RxSwift

struct CharactersDetailViewModel {
    
    let characterId: Observable<String>
    let activityIndicator = ActivityIndicator()
    
    func trackComics() -> Observable<[Comic]> {
        return characterId
            .observeOn(MainScheduler.instance)
            .flatMapLatest { characterId -> Observable<[Comic]> in
                return self.fetchComics(characterId)
        }
    }
    
    internal func fetchComics(characterId: String) -> Observable<[Comic]> {
        return MarvelAPIProvider.request(.Comics(characterId))
            .observeOn(MainScheduler.instance)
            .debug()
            .mapJSON()
            .map { json in
                return Comic.arrayFromJSON(json)
        }
    }
}
