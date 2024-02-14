//  UIButton.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation
import UIKit

extension UIButton {
	static func makeButton(systemName imageName: String, target: Any, action: Selector) -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(systemName: imageName), for: .normal)
		button.tintColor = .white
		button.backgroundColor = .black
		button.layer.cornerRadius = 20
		button.addTarget(target, action: action, for: .touchUpInside)
		return button
	}
}
