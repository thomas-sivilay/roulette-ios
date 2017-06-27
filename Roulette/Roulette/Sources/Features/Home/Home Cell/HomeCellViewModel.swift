//
//  HomeCellViewModel.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/26/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

final class HomeCellViewModel {
    
    // MARK: - Nested
    
    struct State {
        let choice: String
    }
    
    // MARK: - Properties
    
    private(set) var state: State
    
    // MARK: - Initializer
    
    init(state: State) {
        self.state = state
    }
}
