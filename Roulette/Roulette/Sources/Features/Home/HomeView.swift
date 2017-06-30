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
        case start
    }
    
    // MARK: - Properties
    
    private let scrollViewKeyboardAnimator: ScrollViewKeyboardAnimator
    private let action: PublishSubject<HomeView.Action>
    var rx_action: Observable<HomeView.Action> {
        return action.asObservable()
    }
    
    private let bag: DisposeBag
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel) {
        self.action = PublishSubject<HomeView.Action>()
        self.bag = DisposeBag()
        self.scrollViewKeyboardAnimator = ScrollViewKeyboardAnimator(with: scrollView)
        super.init(frame: .zero)
        setUp()
        bind(with: viewModel)
        viewModel.bind(input: rx_action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Properties
    
    private let scrollView = UIScrollView()
    
    private let collectionView: IntrinsicCollectionView = {
        let cv = IntrinsicCollectionView(frame: .zero, collectionViewLayout: HomeCollectionFlowLayout())
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let newChoiceTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // MARK: - Methods
    
    // MARK: Private
    
    private func setUp() {
        backgroundColor = .white
        
        setUpScrollView()
        setUpCollectionView()
        setUpNewButton()
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
    
    private func setUpNewButton() {
        addSubview(newButton)
        newButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.width.equalTo(44)
        }
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
        bindNewButton()
        bindNewChoiceTextField(with: viewModel)
    }
    
    private func bindCollectionView(with viewModel: HomeViewModel) {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, HomeCellViewModel>>()
        
        dataSource.configureCell = { (dataSource, cv, indexPath, element) in
            let cell: HomeCell = cv.dequeueReusableCell(for: indexPath)
            cell.configure(with: element)
            return cell
        }
        
        viewModel.output.choicesItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func bindNewButton() {
        newButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.action.onNext(.start)
            })
            .disposed(by: bag)
    }
    
    private func bindNewChoiceTextField(with viewModel: HomeViewModel) {
        newChoiceTextField.placeholder = viewModel.output.addNewChoicePlaceholder
        newChoiceTextField.delegate = self
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newChoice = textField.text {
            textField.text = ""
            action.onNext(.addNew(choice: newChoice))
        }
        return false
    }
}

extension HomeView.Action: Equatable {
   static func ==(lhs: HomeView.Action, rhs: HomeView.Action) -> Bool {
        switch (lhs, rhs) {
        case (.start, .start):
            return true
        case (.addNew(let choicesA), .addNew(let choicesB)):
            return choicesA == choicesB
        default:
            return false
        }
    }
}
