//
//  HomeCoordinator.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private(set) var presentingViewController: UIViewController?
    
    func start() {
        presentingViewController = HomeViewController()
    }
}
