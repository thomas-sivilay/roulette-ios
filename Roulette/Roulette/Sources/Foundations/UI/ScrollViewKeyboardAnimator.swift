//
//  ScrollViewKeyboardAnimator.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/28/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ScrollViewKeyboardAnimator {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView
    private let observableKeyboard: ObservableKeyboard
    private let bag: DisposeBag
    
    // MARK: - Initializer
    
    init(with scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.observableKeyboard = ObservableKeyboard()
        self.bag = DisposeBag()
        bindScrollView()
    }
    
    // MARK: - Methods
    
    private func bindScrollView() {
        observableKeyboard.height
            .drive(onNext: { [weak self] height in
                self?.scrollView.contentInset.bottom = height
                self?.scrollView.scrollIndicatorInsets.bottom = self?.scrollView.contentInset.bottom ?? 0
            })
            .disposed(by: bag)
    }
}

