//
//  SuperQueryViewModel.swift
//  ReactiveMarvel
//
//  Created by Damian Esteban on 5/27/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import SwiftyJSON
import RxSwift

struct CharactersQueryViewModel {
    
    let query: Observable<String>
    let activityIndicator = ActivityIndicator()
    
    func trackCharacters() -> Observable<[CharacterModel]> {
        return query
            .observeOn(MainScheduler.instance)
            .flatMapLatest { query -> Observable<[CharacterModel]> in
                return self.fetchCharacters(query)
        }
    }

    internal func fetchCharacters(query: String) -> Observable<[CharacterModel]> {
        return MarvelAPIProvider.request(.Characters(query))
            .trackActivity(self.activityIndicator)
            .observeOn(MainScheduler.instance)
            .debug()
            .mapJSON()
            .map { json in
                return CharacterModel.arrayFromJSON(json)
        }
    }
}