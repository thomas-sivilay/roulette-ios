//
//  HomeCell.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class HomeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance methods
    
    // MARK: Internal
    
    func configure(with viewModel: HomeCellViewModel) {
        titleLabel.text = viewModel.state.choice
    }
    
    // MARK: Private
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 20, 0, 20))
        }
    }
}
