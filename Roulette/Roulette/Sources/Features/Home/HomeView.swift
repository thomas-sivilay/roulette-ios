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
    
    init() {
        action = PublishSubject<HomeView.Action>()
        bag = DisposeBag()
        super.init(frame: .zero)
        setUp()
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(state: Driver<HomeViewModel.State>) {
    }
    
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
    
    private func bind() {
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, HomeCellViewModel>>()
        
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                HomeCellViewModel(state: HomeCellViewModel.State(choice: "Choice 1")),
                HomeCellViewModel(state: HomeCellViewModel.State(choice: "Choice 2")),
                ]),
            ])
        
        dataSource.configureCell = { (dataSource, cv, indexPath, element) in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCell
            cell.configure(with: element)
            return cell
        }
        
        items.bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

