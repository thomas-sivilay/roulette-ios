//
//  SpinViewModel.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation
import RxSwift

final class SpinViewModel {
    
    // MARK: - Properties
    
    weak var navigateActionSubscriber: SpinCoordinatorSubscriber?
    
    // MARK: - Methods
    
    func bind(input: Observable<SpinView.Action>) {        
        let navigateAction = input
            .filter { action -> Bool in
                switch action {
                case SpinView.Action.cancel:
                    return true
                }
            }
            .map { _ in
                return SpinCoordinator.NavigationAction.cancel
        }
        
        navigateActionSubscriber?.set(navigationAction: navigateAction)
    }
}
