//
//  SwipeGestion.swift
//  2048
//
//  Created by Gregory Wittmann on 9/15/23.
//

import Foundation
import SwiftUI
import UIKit

class SwipeGestion: ObservableObject {
    @Published var swipeDirection: UISwipeGestureRecognizer.Direction?
    
    init() {
        setupSwipeGestion()
    }
    
    private func setupSwipeGestion() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        UIApllication.shared.keyWindow?.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        UIApllication.shared.keyWindow?.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        UIApllication.shared.keyWindow?.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        UIApllication.shared.keyWindow?.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func handleSwipe(_ gestion: UISwipeGestureRecognizer) {
        swipeDirection = gestion.direction
    }
}
