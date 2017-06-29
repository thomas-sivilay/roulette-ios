//
//  HomeViewController.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView: HomeView
    private let viewModel: HomeViewModel
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.homeView = HomeView(viewModel: viewModel)
        self.bag = DisposeBag()
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

