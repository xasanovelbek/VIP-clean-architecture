//
//  UIButton+Extension.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit
extension UIButton {
    func impulse() {
        UIView.animate(withDuration: 0.3) {
            self.transform = .init(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
    }
}
