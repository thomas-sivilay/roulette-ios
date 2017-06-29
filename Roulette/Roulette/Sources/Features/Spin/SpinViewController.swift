//
//  SpinViewController.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift

final class SpinViewController: UIViewController {
    
    // MARK: - Properties
    
    private let spinView: SpinView
    private let viewModel: SpinViewModel
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init() {
        viewModel = SpinViewModel()
        spinView = SpinView(viewModel: viewModel)
        bag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        self.view = spinView
    }
}


