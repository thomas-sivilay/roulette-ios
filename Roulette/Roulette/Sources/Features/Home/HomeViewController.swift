//
//  HomeViewController.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView: HomeView
    private let viewModel: HomeViewModel
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init() {
        viewModel = HomeViewModel(choices: ["Choice 1", "🎅 - Choice 2", "👮 - Choice 3", "🗣 - Choice 4"])
        homeView = HomeView(viewModel: viewModel)
        bag = DisposeBag()
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        self.view = homeView
    }
}

