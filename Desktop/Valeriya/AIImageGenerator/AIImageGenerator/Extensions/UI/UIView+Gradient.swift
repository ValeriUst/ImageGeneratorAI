//  UIView+Gradient.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import UIKit

extension UIView {
	func gradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.startPoint = startPoint
		gradientLayer.endPoint = endPoint
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
