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
    
    private let titleLabel: UILabel
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
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
        titleLabel.textColor = UIColor.blue
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leadingMargin.trailingMargin.equalTo(20)
        }
    }
}
