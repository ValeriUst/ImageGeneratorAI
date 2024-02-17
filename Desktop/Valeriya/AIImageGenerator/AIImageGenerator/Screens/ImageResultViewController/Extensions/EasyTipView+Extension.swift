//  EasyTipView+Extension.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 17.02.2024.

import Foundation
import EasyTipView

extension ImageResultViewController {
	
	private var tooltip: EasyTipView? {
		get { objc_getAssociatedObject(self, &AssociatedKeys.tooltip) as? EasyTipView }
		set { objc_setAssociatedObject(self, &AssociatedKeys.tooltip, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}
	
	private struct AssociatedKeys {
		static var tooltip = "tooltip"
	}
	
	func createEasyTipView(forView: UIView, text: String, onTap: (() -> Void)?) {
		let textLabel = UILabel()
		textLabel.font = UIFont.sfProSemiBoldItalic(size: 16)
		textLabel.textColor = .white
		textLabel.text = text
		
		let fixedWidth: CGFloat = Constants.toolWidth
		let fixedHeight: CGFloat = Constants.toolHeight
		let textMaxSize = CGSize(width: fixedWidth, height: fixedHeight)
		
		let textSize = textLabel.systemLayoutSizeFitting(textMaxSize)
		textLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: textSize)
		
		let tipView = UIView()
		tipView.addSubview(textLabel)
		
		let tipViewSize = CGSize(width: textSize.width, height: textSize.height)
		tipView.frame = CGRect(origin: .zero, size: tipViewSize)
		
		var preferences = EasyTipView.Preferences()
		preferences.drawing.backgroundColor = Color.violet.withAlphaComponent(0.7)
		preferences.drawing.arrowPosition = .bottom
		preferences.drawing.arrowWidth = Constants.arrowWidth
		preferences.drawing.arrowHeight = Constants.arrowHeight
		preferences.drawing.cornerRadius = Constants.cornerRadius
		preferences.positioning.bubbleInsets = Constants.insets
		preferences.positioning.contentInsets = Constants.insets
		preferences.animating.dismissOnTap = true
		
		let tooltipWidth: CGFloat = Constants.toolWidth
		let tooltipHeight: CGFloat = Constants.toolHeight
		let tooltipX = saveButton.frame.midX - (tooltipWidth / 2)
		let tooltipY = saveButton.frame.minY - tooltipHeight 
		let tooltipFrame = CGRect(x: tooltipX, y: tooltipY, width: tooltipWidth, height: tooltipHeight)
		let tooltip = EasyTipView(contentView: tipView, preferences: preferences)
		self.tooltip = tooltip
		
		tooltip.frame = tooltipFrame
		
		tooltip.show(animated: true, forView: saveButton, withinSuperview: nil)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
			self?.tooltip?.dismiss()
		}
	}
}
