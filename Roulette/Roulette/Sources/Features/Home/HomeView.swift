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
import RxDataSources

final class HomeView: UIView {
    
    // MARK: - Nested
    
    enum Action {
    }
    
    // MARK: - Properties
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeCollectionFlowLayout())
    
    private let action: PublishSubject<HomeView.Action>
    var rx_action: Observable<HomeView.Action> {
        return action.asObservable()
    }
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel) {
        action = PublishSubject<HomeView.Action>()
        bag = DisposeBag()
        super.init(frame: .zero)
        setUp()
        bind(with: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // MARK: Private
    
    private func setUp() {
        setUpCollectionView()
        registerCells()
    }
    
    private func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.red
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func registerCells() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func bind(with viewModel: HomeViewModel) {
        bindCollectionView(with: viewModel)
    }
    
    private func bindCollectionView(with viewModel: HomeViewModel) {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, HomeCellViewModel>>()
        
        dataSource.configureCell = { (dataSource, cv, indexPath, element) in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCell
            cell.configure(with: element)
            return cell
        }
        
        viewModel.choices
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

