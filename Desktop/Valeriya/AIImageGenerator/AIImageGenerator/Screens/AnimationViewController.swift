//  AnimationViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import UIKit
import Lottie

class AnimationViewController: UIViewController {
	
	// MARK: - Constants
	private var timeIntervalSeconds: TimeInterval = 10
	
	private var timeStepSeconds: Int = 10
	
	private var duration: Double = 0.5
	
	private let topOffsetsLabel = 100
	
	// MARK: - Content Views
	private var animationView: LottieAnimationView?
	
	private let countLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		return label
	}()
	
	private let waitLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.text = "We need a little bit more time..."
		label.alpha = 0
		return label
	}()
	
	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViews()
		setupAnimationView()
    }
	
	private func configureViews() {
		view.backgroundColor = .black
		view.addSubviews([countLabel, waitLabel])
		setConstraints()
	}
	
	//MARK: - Methods
	private func setupAnimationView() {
		animationView?.backgroundColor = .clear
		animationView = .init(name: "plane")
		animationView?.frame = view.bounds
		animationView?.loopMode = .loop
		animationView?.play()
		view.addSubview(animationView!)
		startAnimation()
	}
	
	private func startAnimation() {
	
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			guard let self = self else { return }
			
			let animationDuration: TimeInterval = self.timeIntervalSeconds
			let animationSteps = self.timeStepSeconds
			for step in (0...animationSteps).reversed() {
				DispatchQueue.main.async {
					self.countLabel.text = "Estimated time \(step) sec"
				}
				Thread.sleep(forTimeInterval: animationDuration / TimeInterval(animationSteps))
			}
			
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				
				UIView.animate(withDuration: self.duration, animations: {
					self.countLabel.removeFromSuperview()
					self.waitLabel.alpha = 1 // Появление лейбла waitLabel
				})
			}
		}
	}

	// MARK: - Constraints
	private func setConstraints() {
		countLabel.snp.makeConstraints { label in
			label.top.equalToSuperview().offset(topOffsetsLabel)
			label.centerX.equalToSuperview()
		}
		waitLabel.snp.makeConstraints { label in
			label.top.equalToSuperview().offset(topOffsetsLabel)
			label.centerX.equalToSuperview()
		}
	}
}
