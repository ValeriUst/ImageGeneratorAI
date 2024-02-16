//  ImageViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import UIKit
import Kingfisher

final class ImageResultViewController: UIViewController {
	
	// MARK: - Constants	
	private let defaultURL = URL(string: "https://example.com/default_image.png")// ??
	private let bottomLabelOffset = 10
	
	var imageURL: URL?

	// MARK: - Content Views
	
	private let imageResult = UIImageView()

	//UIButtons
	private let openButton = UIButton.makeButton(systemName: "eye.circle", target: self, action:  #selector(openButtonTapped))
	
	private let saveButton = UIButton.makeButton(systemName: "arrow.down.circle", target: self, action:  #selector(saveButtonTapped))
	
	private let backButton = UIButton.makeButton(systemName: "chevron.backward.circle", target: self, action:  #selector(backButtonTapped))
	
	private let timeLabel = UILabel.makeLabel(text: "", font: UIFont.sfProBold(size: 80) ?? .systemFont(ofSize: 80), textColor: .white, isHidden: true)
	
	private let dateLabel = UILabel.makeLabel(text: "", font: UIFont.sfProBold(size: 15) ?? .systemFont(ofSize: 80), textColor: .white, isHidden: true)

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViews()
		setConstraints()
		loadImage(from: (imageURL ?? defaultURL)!)
		updateTimeAndDate()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	private func configureViews() {
		view.backgroundColor = .black
		view.addSubviews([imageResult, backButton, saveButton, openButton, timeLabel, dateLabel])
		setConstraints()
	}
	
	//MARK: - Methods
	@objc private func backButtonTapped() {
		let vc = CreateImageController()
		navigationController?.pushViewController(vc, animated: false)
	}
	
	@objc private func saveButtonTapped() {
		guard let selectedImage = imageResult.image else {
			return
		}
		
		// Создаем обратную связь в виде вибрации
		let feedbackGenerator = UINotificationFeedbackGenerator()
		
		// Срабатывает вибрация
		feedbackGenerator.notificationOccurred(.success)
		print("Вибрация запущена") // для проверки вкл вибрации
		
		// Сохраняем изображение в галерее
		UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
	}
	
	@objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			showAlertWith(title: "Ошибка сохранения", message: error.localizedDescription)
		} else {
			showAlertWith(title: "Сохранено!", message: "Ваше изображение было сохранено в галерее.")
		}
	}
	
	@objc private func openButtonTapped() {
		timeLabel.isHidden.toggle()
		dateLabel.isHidden.toggle()
	}
	
	@objc private func updateTimeAndDate() {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		let timeString = formatter.string(from: Date())
		timeLabel.text = timeString
		
		formatter.dateFormat = "EEEE, MMMM dd"
		let dateString = formatter.string(from: Date())
		dateLabel.text = dateString
	}
	
	//MARK: - Helper Methods
	private func showAlertWith(title: String, message: String){
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
	
	// MARK: - Configure
	// Загрузить изображение с помощью Kingfisher
	private func loadImage(from imageURL: URL) {
		let options: KingfisherOptionsInfo = [
			.transition(.fade(0.3)),
			.scaleFactor(UIScreen.main.scale),
			.cacheOriginalImage
		]
		imageResult.kf.setImage(with: imageURL,
								placeholder: nil,
								options: options,
								progressBlock: nil) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let value):
				// Устанавливаем загруженное изображение в imageResult
				self.imageResult.image = value.image
				
			case .failure(let error):
				print("Ошибка в контроллере изображения:", error.localizedDescription)
			}
		}
	}

	// MARK: - Constraints
	private func setConstraints() {
		imageResult.snp.makeConstraints { image in
			image.edges.equalToSuperview()
		}
		backButton.snp.makeConstraints { button in
			button.top.equalToSuperview().offset(Constants.bottomTopOffset)
			button.leading.equalToSuperview().offset(Constants.bottomOffsets)
			button.height.width.equalTo(Constants.sizeButton)
		}
		backButton.imageView?.snp.makeConstraints { make in
			make.edges.equalTo(backButton)
		}
		openButton.snp.makeConstraints { button in
			button.bottom.equalToSuperview().offset(-Constants.sizeButton)
			button.leading.equalToSuperview().offset(Constants.bottomOffsets)
			button.height.width.equalTo(Constants.sizeButton)
		}
		openButton.imageView?.snp.makeConstraints { make in
			make.edges.equalTo(openButton)
		}
		saveButton.snp.makeConstraints { button in
			button.bottom.equalToSuperview().offset(-Constants.sizeButton)
			button.trailing.equalToSuperview().offset(-Constants.bottomOffsets)
			button.height.width.equalTo(Constants.sizeButton)
		}
		saveButton.imageView?.snp.makeConstraints { make in
			make.edges.equalTo(saveButton)
		}
		dateLabel.snp.makeConstraints { label in
			label.centerX.equalToSuperview()
			label.top.equalToSuperview().offset(Constants.bottomTopOffset)
		}
		timeLabel.snp.makeConstraints { label in
			label.centerX.equalToSuperview()
			label.top.equalTo(dateLabel.snp.bottom).offset(self.bottomLabelOffset)

		}
	}
}
