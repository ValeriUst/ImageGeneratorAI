//  ViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import UIKit
import SnapKit

class CreateImageController: UIViewController {
	
	// MARK: - Constants
	
	// MARK: - Content Views
	private func addGradient() {
		let screenHeight = UIScreen.main.bounds.height // ширина градиента равна ширины экрана
		let gradientHeight = screenHeight / 4 // высота градиента равна 1/4 высоты экрана
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [
			Color.violet.cgColor,
			UIColor.black.cgColor
		]
		gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: gradientHeight)
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		view.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	private let searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "arrowshape.up.circle"), for: .normal)
		button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
		return button
	}()
	
	private let searchBar: UISearchBar = {
		let search = UISearchBar()
		search.layer.borderWidth = Constants.borderWidth
		search.layer.borderColor = UIColor.white.cgColor
		search.keyboardAppearance = .dark
		search.tintColor = .white
		search.barTintColor = .clear
		search.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		search.layer.cornerRadius = Constants.cornerRadius
		search.searchTextField.leftView = nil
		return search
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		addGradient()
		view.addSubviews([searchBar])
		searchBar.addSubviews([searchButton])
		searchBar.delegate = self
		setConstraints()
		setupKeyboard()
	}
	
	//MARK: - Methods
	@objc private func searchButtonTapped() {
		if let searchText = searchBar.text {
			searchBarSearchButtonClicked(searchBar)
		}
	}

	// MARK: - Configure
	
	// MARK: - Constraints
	private func setConstraints() {
		searchBar.snp.makeConstraints { search in
			search.leading.equalToSuperview().offset(Constants.standardOffset)
			search.trailing.equalToSuperview().inset(Constants.standardOffset)
			search.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Constants.bottomOffsets)
		}
		searchButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(Constants.trailingOffset)
			make.centerY.equalToSuperview()
		}
	}
}

// MARK: - Extension UISearchBarDelegate
extension CreateImageController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		searchBar.resignFirstResponder() // Скрыть клавиатуру

	}
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
}

// MARK: - Extension UITapGestureRecognizer
extension UIViewController {
	func setupKeyboard() {
		let tapGesture = UITapGestureRecognizer(target: self, 
												action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
	}
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
