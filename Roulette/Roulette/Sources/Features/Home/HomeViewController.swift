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
        homeView = HomeView()
        viewModel = HomeViewModel(state: HomeViewModel.State(choices: [String]()))
        bag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        self.view = homeView
    }
    
    // MARK: - Methods
    
    // MARK: Private
    
    private func bind() {
        homeView.update(state: viewModel.state)
        homeView.rx_action.asObservable()
            .subscribe(onNext: { [weak self] (string) in
                self?.viewModel.reduce(action: string)
            })
            .disposed(by: bag)
    }
}

