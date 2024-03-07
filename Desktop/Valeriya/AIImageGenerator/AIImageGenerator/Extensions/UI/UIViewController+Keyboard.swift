//  UIViewController+Keyboard.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import UIKit

// MARK: - Extension UITapGestureRecognizer
extension UIViewController {
	
	// Настройка клавиатуры для скрытия при касании на экран
	func setupKeyboard() {
		let tapGesture = UITapGestureRecognizer(target: self,
												action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
	}
	
	// Скрытие клавиатуры по тапу на экран
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

