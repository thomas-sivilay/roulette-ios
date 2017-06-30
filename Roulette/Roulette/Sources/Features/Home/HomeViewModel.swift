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

final class HomeViewModel {
    
    // MARK: - Properties
    
    struct Input {
        var action: Observable<HomeView.Action>
    }
    
    struct Output {
        var choicesItems: Observable<[SectionModel<String, HomeCellViewModel>]>
        var addNewChoicePlaceholder: String
    }
    
    var output: Output {
        let choicesItems = choices
            .asObservable()
            .flatMap { (choices) -> Observable<[SectionModel<String, HomeCellViewModel>]> in
                let items = choices
                    .flatMap {  HomeCellViewModel(state: HomeCellViewModel.State(choice: $0)) }
                return Observable.just([SectionModel(model: "First section", items: items)])
            }
        
        return Output(
            choicesItems: choicesItems,
            addNewChoicePlaceholder: "Enter a new choices.."
        )
    }
        
    weak var navigateActionSubscriber: HomeCoordinatorSubscriber?
    
    private var choices: Variable<[String]> = Variable([])
    
    // MARK: - Initializer
    
    init(choices: [String]) {
        self.choices.value = choices
    }
    
    // MARK: - Methods
    
    func bind(input: Observable<HomeView.Action>) {
        input
            .subscribe(onNext: { [weak self] (action) in
                switch action {
                case let .addNew(choice: name):
                    self?.choices.value.append(name)
                default:
                    break
                }
            })
        
        let choices = self.choices.value
        
        let navigateAction = input
            .filter { (action) -> Bool in
                switch action {
                case HomeView.Action.start:
                    return true
                default:
                    return false
                }
            }
            .map { _ in
                return HomeCoordinator.NavigationAction.start(choices: choices)
            }
        
        navigateActionSubscriber?.set(navigationAction: navigateAction)
    }
}
