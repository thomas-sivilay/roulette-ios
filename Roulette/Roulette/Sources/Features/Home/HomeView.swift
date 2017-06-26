//
//  HomeView.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        print("Toto")
    }
}

