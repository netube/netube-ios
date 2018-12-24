//
//  GradientTableViewCell.swift
//  Netube
//
//  Created by Bing Djeung on 12/24/18.
//  Copyright © 2018 Netube. All rights reserved.
//

import UIKit

class GradientTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .default, reuseIdentifier: Idetifier.gradientTableViewCell.rawValue)
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
        
        
        /// Gradient Color Text
        ///
        /// This function should be called **after** set up `textLabel?.text` .
        ///
        /// - Parameters:
        ///   - startColor: start color
        ///   - endColor: end color
        ///   - isLeftToRight: is gradient from left to right
        ///
        func setGradient(from startColor: UIColor = .lightText, to endColor: UIColor = .darkText, isLeftToRight: Bool = false) {
                let gradient: CAGradientLayer = CAGradientLayer()
                gradient.colors = [startColor.cgColor, endColor.cgColor]
                if isLeftToRight {
                        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
                        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
                }
                gradient.frame = bounds
                layer.insertSublayer(gradient, at: 0)
                mask = textLabel
        }
}
