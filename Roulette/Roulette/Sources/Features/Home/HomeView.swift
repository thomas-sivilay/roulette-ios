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
import RxDataSources

final class HomeView: UIView {
    
    // MARK: - Nested
    
    enum Action {
        case addNew(choice: String)
    }
    
    // MARK: - Properties
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeCollectionFlowLayout())
    private let newChoiceTextField = UITextField()
    
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
        viewModel.bind(input: rx_action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // MARK: Private
    
    private func setUp() {
        backgroundColor = UIColor.white
        
        setUpCollectionView()
        setUpNewChoiceTextField()
        registerCells()
    }
    
    private func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.clear
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func registerCells() {
        collectionView.register(HomeCell.self)
    }
    
    private func setUpNewChoiceTextField() {
        addSubview(newChoiceTextField)
        
        newChoiceTextField.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottomMargin)
            make.height.equalTo(50)
        }
    }
    
    private func bind(with viewModel: HomeViewModel) {
        bindCollectionView(with: viewModel)
        bindNewChoiceTextField()
    }
    
    private func bindCollectionView(with viewModel: HomeViewModel) {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, HomeCellViewModel>>()
        
        dataSource.configureCell = { (dataSource, cv, indexPath, element) in
            let cell: HomeCell = cv.dequeueReusableCell(for: indexPath)
            cell.configure(with: element)
            return cell
        }
        
        viewModel.choicesItems
            .debug()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func bindNewChoiceTextField() {
        newChoiceTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .subscribe( { [weak self] _ in
                self?.action.onNext(.addNew(choice: self?.newChoiceTextField.text ?? "TOTO"))
            })
            .disposed(by: bag)
    }
}

