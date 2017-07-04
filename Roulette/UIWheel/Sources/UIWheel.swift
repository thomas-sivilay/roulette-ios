//
//  UIWheel.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/4/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIWheel: UIView {
    
    // MARK: - Properties
    
    public var choices: [String]
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        self.choices = []
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    // MARK: - Methods
    
}
