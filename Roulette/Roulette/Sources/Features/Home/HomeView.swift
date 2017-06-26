//
//  HomeView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeView: UIView {
    
    // MARK: - Nested
    
    enum Action {
        
    }
    
    // MARK: - Properties
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let action: PublishSubject<HomeView.Action>
    var rx_action: Observable<HomeView.Action> {
        return action.asObservable()
    }
    
    // MARK: - Initializers
    
    init() {
        action = PublishSubject<HomeView.Action>()
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(state: Driver<HomeViewModel.State>) {
//        state
//            .map { $0.choices }
//            .distinctUntilChanged()
        
//        collectionView.rx.setDataSource()
    }
    
    // MARK: Private
    
    private func setUp() {
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.red
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

