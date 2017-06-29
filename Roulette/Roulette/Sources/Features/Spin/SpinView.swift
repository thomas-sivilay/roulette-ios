//
//  SpinView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/29/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class SpinView: UIView {
    
    // MARK: - Initializers
    
    init(viewModel: SpinViewModel) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
