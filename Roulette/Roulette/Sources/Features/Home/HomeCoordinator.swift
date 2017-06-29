//
//  HomeCoordinator.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeCoordinatorSubscriber: class {
    func set(navigationAction: Observable<HomeCoordinator.NavigationAction>)
}

final class HomeCoordinator: Coordinator {
    
    // MARK: - Nested
    
    enum NavigationAction {
        case start(choices: [String])
    }
    
    // MARK: - Properties
    
    private(set) var presentingViewController: UIViewController?
    private var childCoordinators: [Coordinator]
    private let bag: DisposeBag
    
    // MARK: - Initializer
    
    init() {
        self.bag = DisposeBag()
        self.childCoordinators = []
    }
    
    // MARK: - Methods
    
    func start() {
        let viewModel = HomeViewModel(choices: [])
        viewModel.navigateActionSubscriber = self
        presentingViewController = HomeViewController(with: viewModel)
    }
    
    private func perform(_ navigateAction: NavigationAction) {
        switch navigateAction {
        case let .start(choices):
            showSpin(with: choices)
        }
    }
    
    private func showSpin(with choices: [String]) {
        let spinCoordinator = SpinCoordinator(choices: choices)
        spinCoordinator.start()
        childCoordinators.append(spinCoordinator)
        if let vc = spinCoordinator.presentingViewController {
            presentingViewController?.present(vc, animated: true)
        }
    }
}

extension HomeCoordinator: HomeCoordinatorSubscriber {
    
    func set(navigationAction: Observable<HomeCoordinator.NavigationAction>) {
        navigationAction
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] action in
                self?.perform(action)
            })
            .disposed(by: bag)
    }
}
