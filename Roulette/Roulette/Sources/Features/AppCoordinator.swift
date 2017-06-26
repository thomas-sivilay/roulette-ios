//
//  AppCoordinator.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var childCoordinators: [Coordinator]
    
    init(window: UIWindow) {
        self.window = window
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let coordinator = HomeCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start()
        window.rootViewController = coordinator.presentingViewController
        window.makeKeyAndVisible()
    }
}
