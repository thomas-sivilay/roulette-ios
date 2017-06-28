//
//  IntrinsicCollectionView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/28/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class IntrinsicCollectionView: UICollectionView {
    
    // MARK: - Nested
    
    fileprivate enum Constant {
        enum UI {
            static let width = UIScreen.main.bounds.size.width
        }
    }
    
    // MARK: - Properties
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constant.UI.width, height: contentSize.height)
    }
}
