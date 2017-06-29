//
//  SpinView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift

final class SpinView: UIView {
    
    // MARK: - Nested
    
    enum Action {
        case cancel
    }
    
    // MARK: - Properties
    
    private let bag: DisposeBag
    private let action: PublishSubject<SpinView.Action>
    var rx_action: Observable<SpinView.Action> {
        return action.asObservable()
    }
    
    // MARK: - Initializers
    
    init(viewModel: SpinViewModel) {
        self.action = PublishSubject<SpinView.Action>()
        self.bag = DisposeBag()
        super.init(frame: .zero)
        setUp()
        bind()
        viewModel.bind(input: rx_action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Properties
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // MARK: - Methods
    
    private func setUp() {
        backgroundColor = .white
        
        setUpCancelButton()
    }
    
    private func setUpCancelButton() {
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.height.width.equalTo(44)
        }
    }
    
    private func bind() {
        bindCancelButton()
    }
    
    private func bindCancelButton() {
        cancelButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.action.onNext(.cancel)
            })
            .disposed(by: bag)
    }
}
