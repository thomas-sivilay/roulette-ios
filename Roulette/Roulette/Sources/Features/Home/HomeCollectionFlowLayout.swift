//
//  HomeCollectionFlowLayout.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/27/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class HomeCollectionFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Nested
    
    private enum Constant {
        enum Layout {
            static let spacing: CGFloat = 0
            static let width: CGFloat = UIScreen.main.bounds.size.width
            static let height: CGFloat = 50
        }
    }
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        self.itemSize = CGSize(width: Constant.Layout.width, height: Constant.Layout.height)
        self.minimumLineSpacing = Constant.Layout.spacing
        self.minimumInteritemSpacing = Constant.Layout.spacing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

