//
//  KeyboardNotificationObserver.swift
//  Roulette
//
//  Created by Thomas Sivilay on 6/28/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ObservableKeyboard {
    
    // MARK: - Properties
    
    var height: Driver<CGFloat> = Driver.empty()
    
    // MARK: - Initializer
    
    init() {
        setUp()
    }
    
    // MARK: - Methods
    
    private func setUp() {
        let willHideNotification = NotificationCenter.default.rx.notification(.UIKeyboardWillHide)
        let willChangeNotification = NotificationCenter.default.rx.notification(.UIKeyboardWillChangeFrame)
        
        let willHideFrame = willHideNotification
            .map { notification -> CGRect in
                return .zero
            }
        
        let willChangeFrame = willChangeNotification
            .map { notification -> CGRect in
                let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
                return rectValue?.cgRectValue ?? .zero
            }
        
        height = Observable
            .of(willHideFrame, willChangeFrame)
            .merge()
            .map { $0.height }
            .asDriver(onErrorJustReturn: 0)
    }
}

