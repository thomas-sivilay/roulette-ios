//
//  SpinView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UIWheel

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
    
    private let label = UILabel()
    private let wheelView = UIWheel(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
    private var tap: UITapGestureRecognizer?
    private var pan: UIPanGestureRecognizer?
    private var t: Observable<Int> = Observable.empty()
    private var v: Variable<Int> = Variable<Int>(0)
    
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
        setUpWheel()
        setUpLabel()
    }
    
    private func setUpWheel() {
        wheelView.backgroundColor = .black
        wheelView.choices = ["1", "2", "3", "4", "5", "6"]
        addSubview(wheelView)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(SpinView.tapGestureTapped(recognizer:)))
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(SpinView.panGestureTapped(recognizer:)))
        
        wheelView.addGestureRecognizer(tap!)
        wheelView.addGestureRecognizer(pan!)
        
//        wheelView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(superview?.snp.width ?? 300)
//        }
        
    }
    
    private func setUpLabel() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(wheelView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        wheelView.currentSelectedIndex
            .map { value in
                return String(value)
            }
            .bind(to: label.rx.text)
            .disposed(by: bag)
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
    
    @objc
    func tapGestureTapped(recognizer: UITapGestureRecognizer) {
        wheelView.animate()
    }
    
    @objc
    func panGestureTapped(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let t = recognizer.velocity(in: self)
            let velocityX = Float(t.y) / 1000
            wheelView.animate(velocity: velocityX)
        }
    }
}
