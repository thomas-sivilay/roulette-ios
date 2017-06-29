//
//  SpinCoordinator.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift

protocol SpinCoordinatorSubscriber: class {
    func set(navigationAction: Observable<SpinCoordinator.NavigationAction>)
}

final class SpinCoordinator: Coordinator {
    
    // MARK: - Nested
    
    enum NavigationAction {
        case cancel
    }
    
    // MARK: - Properties
    
    private let bag: DisposeBag
    private(set) var presentingViewController: UIViewController?
    private let choices: [String]
    
    // MARK: - Initializer
    
    init(choices: [String]) {
        self.bag = DisposeBag()
        self.choices = choices
    }
    
    deinit {
        print("DEINIT")
    }
    
    // MARK: - Methods
    
    func start() {
        let viewModel = SpinViewModel()
        viewModel.navigateActionSubscriber = self
        presentingViewController = SpinViewController(with: viewModel)
    }
    
    private func perform(_ navigateAction: NavigationAction) {
        switch navigateAction {
        case .cancel:
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension SpinCoordinator: SpinCoordinatorSubscriber {
    
    func set(navigationAction: Observable<SpinCoordinator.NavigationAction>) {
        navigationAction
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] action in
                self?.perform(action)
            })
            .disposed(by: bag)
    }
}
