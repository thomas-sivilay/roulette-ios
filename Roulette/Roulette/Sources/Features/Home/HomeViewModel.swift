//
//  HomeViewModel.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    // MARK: - Nested
    
    struct State {
        let choices: [String]?
    }
    
    // MARK: - Properties
    
    private var mutableState = PublishSubject<State>()
    
    var state: Driver<State> {
        return mutableState.asDriver(onErrorJustReturn: State(choices: nil))
    }
        
    // MARK: - Initializer
    
    init(state: State) {
        self.mutableState.onNext(state)
    }
    
    // MARK: - Methods
    
    func reduce(action: HomeView.Action) {
        
    }
}
