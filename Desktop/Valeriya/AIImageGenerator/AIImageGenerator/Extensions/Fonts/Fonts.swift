//  Fonts.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 13.02.2024.

import Foundation
import UIKit

extension UIFont {
	static func sfProBlack(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-BlackItalic", size: size)
	}
	static func sfProBold(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-Bold", size: size)
	}
	static func sfProMedium(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-Medium", size: size)
	}
	static func sfProRegular(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-Regular", size: size)
	}
	static func sfProSemiBoldItalic(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-SemiboldItalic", size: size)
	}
	static func sfProSemiBold(size: CGFloat) -> UIFont? {
		return UIFont(name: "SFProDisplay-Semibold", size: size)
	}
}
