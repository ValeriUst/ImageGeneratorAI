//  ViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addGradient()
	}
	
	private func addGradient() {
		let screenHeight = UIScreen.main.bounds.height
		let gradientHeight = screenHeight / 6 // высота градиента равна 1/6 высоты экрана
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [
			UIColor.purple.cgColor,
			UIColor.black.cgColor
		]
		gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: gradientHeight)
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		
		view.layer.insertSublayer(gradientLayer, at: 0)
	}
}
