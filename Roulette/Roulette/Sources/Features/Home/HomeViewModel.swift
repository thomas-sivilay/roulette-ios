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
import RxDataSources

protocol HomeViewModelOutput {
    var choices: Observable<[SectionModel<String, HomeCellViewModel>]> { get }
}

final class HomeViewModel: HomeViewModelOutput {
    
    // MARK: - Properties
    
    var choices: Observable<[SectionModel<String, HomeCellViewModel>]>
    
    // MARK: - Initializer
    
    init(choices: [String]) {
        let items = choices
            .flatMap {  HomeCellViewModel(state: HomeCellViewModel.State(choice: $0)) }
        
        self.choices = Observable.just([
            SectionModel(model: "First section", items: items),
            ])
    }
}
