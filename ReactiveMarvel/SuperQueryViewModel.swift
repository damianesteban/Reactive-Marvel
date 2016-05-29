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

struct SuperQueryViewModel {
    
    let query: Observable<String>
    let activityIndicator = ActivityIndicator()
    
    func trackSupers() -> Observable<[Super]> {
        return query
            .observeOn(MainScheduler.instance)
            .flatMapLatest { query -> Observable<[Super]> in
                return self.fetchSupers(query)
        }
    }

    internal func fetchSupers(query: String) -> Observable<[Super]> {
        return MarvelAPIProvider.request(.Supers(query))
            .trackActivity(self.activityIndicator)
            .observeOn(MainScheduler.instance)
            .debug()
            .mapJSON()
            .map { json in
                return Super.arrayFromJSON(json)
        }
    }
}