//  ViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import UIKit
import SnapKit

class CreateImageController: UIViewController {
	
	// MARK: - Constants
	private var modelData: [ImageModel] = [ImageModel]()

	
	// MARK: - Content Views
	
	// Добавление градиента на экран
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
		fetchData(searchText: searchBar.text ?? "")
	}

	//MARK: - Methods
	
	// Нажатия на кнопку поиска
	@objc private func searchButtonTapped() {
		if searchBar.text != nil {
			searchBarSearchButtonClicked(searchBar)
		}
	}

	// MARK: - Configure
	
	private func fetchData(searchText: String) {
		// Проверяем, валиден ли URL
		guard URL(string: ConstantsAPI.baseURL) != nil else {
			print("Invalid URL")
			return
		}
		// Создаем данные для отправки на сервер
		let requestData: [String: Any] = [
			"key": ConstantsAPI.API_KEY,
			"prompt": searchText,
		]
		do {
			// Конвертируем данные в JSON
			let jsonData = try JSONSerialization.data(withJSONObject: requestData)
			
			// Отправляем запрос на сервер с использованием текста из поисковой строки
			APICaller.shared.sendPostRequest(jsonData: jsonData, searchText: searchText) { [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(let responseString):
					print("Response from server: \(responseString)")
				case .failure(let error):
					print("Error: \(error.localizedDescription)")
				}
			}
		} catch {
			print("Failed to convert data to JSON: \(error.localizedDescription)")
		}
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		searchBar.snp.makeConstraints { search in
			search.leading.equalToSuperview().offset(Constants.standardOffset)
			search.trailing.equalToSuperview().inset(Constants.standardOffset)
			search.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Constants.bottomOffsets)
			search.height.equalTo(50)
		}
		searchButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(Constants.trailingOffset)
			make.centerY.equalToSuperview()
		}
	}
}

// MARK: - Extension UISearchBarDelegate

extension CreateImageController: UISearchBarDelegate {
	
	// Обработка нажатия на кнопку поиска
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		
		searchBar.resignFirstResponder() // Скрыть клавиатуру
	
		print("Отправляют \(searchText)")
		
		fetchData(searchText: searchText)
	}
	
	// Редактирование searchBar
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
}
