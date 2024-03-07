//  Constans.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import UIKit

struct Constants {
	static let cornerRadius: CGFloat = 16
	static let cornerRadiusCircle: CGFloat = 20
	static let borderWidth: CGFloat = 2
	static let alphaYes: CGFloat = 1
	static let alphaNo: CGFloat = 0
	static let toolWidth: CGFloat = 150
	static let toolHeight: CGFloat = 50
	static let arrowWidth: CGFloat = 16
	static let arrowHeight: CGFloat = 10
	static let insets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
	static let toolTextWidth: CGFloat = 200
	static let toolTextHeight: CGFloat = 50
	
	static let timeIntervalSeconds: TimeInterval = 10
	static let timeStepSeconds: Int = 10
	static let duration: Double = 0.5
	static let topOffsetsLabel: Int = 100

	static let standardOffset = 16
	static let bottomOffsets = 25
	static let trailingOffset = 8
	static let sizeButton = 40
	static let searchHight = 50
	static let bottomTopOffset = 70

	static let waitText: String = "We need a little bit more time..."
	static let alertErrorTitle: String = "Ошибка"
	static let alertErrorClose: String = "Закрыть"
	static let alertErrorMessage: String = "Изображение недоступно"
	static let alertTipViewOk: String = "Изображение не сохранено"
	static let alertTipViewError: String = "Cохранено в галерее"
	static let alertImageErrorTitle: String = "Ошибка"
	static let alertImageErrorText: String = "Загрузка невозможна"
	static let alertImageErrorReturn: String = "Повторить"
	static let alertImageErrorClose: String = "Закрыть"
	static let errorImage: String = "Ошибка в контроллере изображения:"
	
	static let dateHours: String = "HH:mm"
	static let dateFormatter: String = "EEEE, MMMM dd"
}
