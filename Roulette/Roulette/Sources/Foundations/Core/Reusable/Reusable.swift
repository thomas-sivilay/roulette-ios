//
//  Reusable.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/27/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reusableIdentifier: String { get }
}

extension UICollectionViewCell: Reusable {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        
        return cell
    }
}
