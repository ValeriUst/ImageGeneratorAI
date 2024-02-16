//  ViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import UIKit
import SnapKit

final class CreateImageController: UIViewController {
		
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
	
	private let searchButton = UIButton.makeButton(systemName: "arrow.up.circle", target: self, action:  #selector(searchButtonTapped))
	
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
		configureViews()
		setupKeyboard()
	}

	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	// MARK: - Configure
	private func configureViews() {
		view.addSubviews([searchBar])
		searchBar.addSubviews([searchButton])
		searchBar.delegate = self
		addGradient()
		setConstraints()
	}

	private func fetchData(searchText: String) {
		
		APICaller.shared.sendPostRequest(searchText: searchText) { [weak self] result in
			guard let self = self else { return }
			
			DispatchQueue.main.async {
								
				switch result {
				case .success(let imageModel):
					guard let imageURLString = imageModel.output?.first,
						  let imageURL = URL(string: imageURLString) else {
						return
					}
					print("загрузили картинку\(imageURL)")
					
					let vc = ImageResultViewController()
					vc.imageURL = imageURL
					
					// Отложенный переход на 4 секунды
					DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
						self.navigationController?.pushViewController(vc, animated: true)
					}
				case .failure(let error):
					print("Ошибка при выполнении запроса: \(error.localizedDescription)")
					
					let alert = UIAlertController(title: "Ошибка", message: "Загрузка невозможна", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
						// Повторяем загрузку данных
						self.fetchData(searchText: searchText)
						self.pushViewController(vc: AnimationViewController())
					}))
					alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
						self.pushViewController(vc: CreateImageController())
					}))
					self.present(alert, animated: true, completion: nil)
				}
			}
		}
	}
	
	//MARK: - Methods
	// Нажатия на кнопку поиска
	@objc private func searchButtonTapped() {
		searchBar.text != nil ? searchBarSearchButtonClicked(searchBar) : ()
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		searchBar.snp.makeConstraints { search in
			search.leading.equalToSuperview().offset(Constants.standardOffset)
			search.trailing.equalToSuperview().inset(Constants.standardOffset)
			search.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Constants.bottomOffsets)
			search.height.equalTo(Constants.searchHight)
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
		fetchData(searchText: searchText)
		pushViewController(vc: AnimationViewController())
	}
	
	private func pushViewController(vc: UIViewController) {
		navigationController?.pushViewController(vc, animated: true)
	}

	// Редактирование searchBar
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
}
