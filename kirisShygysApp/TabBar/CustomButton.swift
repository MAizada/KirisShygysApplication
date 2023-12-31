//
//  CustomButton.swift
//  kirisShygysApp
//
//  Created by Aizada on 12.09.2023.
//

import UIKit

    class CustomButton: UIButton {
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let buttonSize: CGFloat = 60
            let extendedArea: CGFloat = 10 // Расширенная область вокруг кнопки, где она будет отвечать на нажатие
            let extendedRect = CGRect(x: -extendedArea, y: -extendedArea, width: buttonSize + 2 * extendedArea, height: buttonSize + 2 * extendedArea)
            
            if extendedRect.contains(point) {
                return self
            }
            
            return super.hitTest(point, with: event)
        }
    }

    
