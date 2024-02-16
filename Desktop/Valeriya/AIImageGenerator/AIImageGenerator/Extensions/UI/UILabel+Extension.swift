//  UILabel+Extension.swift.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 16.02.2024.

import Foundation
import UIKit

extension UILabel {
	static func makeLabel(text: String, font: UIFont, textColor: UIColor, isHidden: Bool) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = font
		label.textColor = textColor
		label.isHidden = isHidden
		return label
	}
}
