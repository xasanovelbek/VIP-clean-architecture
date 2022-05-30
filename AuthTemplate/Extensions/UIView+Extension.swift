//
//  UIView+Extension.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit
extension UIView {
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return nil }
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds

           layer.insertSublayer(gradientLayer, at: 0)
    }
}
