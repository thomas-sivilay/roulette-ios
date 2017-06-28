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
    
    private let scrollViewKeyboardAnimator: ScrollViewKeyboardAnimator
    private let scrollView = UIScrollView()
    private let collectionView: IntrinsicCollectionView = {
        let cv = IntrinsicCollectionView(frame: .zero, collectionViewLayout: HomeCollectionFlowLayout())
        cv.backgroundColor = .clear
        return cv
    }()
    private let newChoiceTextField: UITextField = {
       let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    private let action: PublishSubject<HomeView.Action>
    var rx_action: Observable<HomeView.Action> {
        return action.asObservable()
    }
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel) {
        action = PublishSubject<HomeView.Action>()
        bag = DisposeBag()
        scrollViewKeyboardAnimator = ScrollViewKeyboardAnimator(with: scrollView)
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
        backgroundColor = .white
        
        setUpScrollView()
        setUpCollectionView()
        setUpNewChoiceTextField()
        registerCells()
    }
    
    private func setUpScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
        }
    }
    
    private func registerCells() {
        collectionView.register(HomeCell.self)
    }
    
    private func setUpNewChoiceTextField() {
        scrollView.addSubview(newChoiceTextField)
        newChoiceTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func bind(with viewModel: HomeViewModel) {
        bindCollectionView(with: viewModel)
        bindNewChoiceTextField(with: viewModel)
    }
    
    private func bindCollectionView(with viewModel: HomeViewModel) {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, HomeCellViewModel>>()
        
        dataSource.configureCell = { (dataSource, cv, indexPath, element) in
            let cell: HomeCell = cv.dequeueReusableCell(for: indexPath)
            cell.configure(with: element)
            return cell
        }
        
        viewModel.choicesItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func bindNewChoiceTextField(with viewModel: HomeViewModel) {
        newChoiceTextField.placeholder = viewModel.addNewChoicePlaceholder
        
        newChoiceTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .subscribe( { [weak self] _ in
                self?.action.onNext(.addNew(choice: self?.newChoiceTextField.text ?? "TOTO"))
                self?.newChoiceTextField.text = ""
            })
            .disposed(by: bag)
    }
}

