//  AnimationViewController.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import UIKit
import Lottie

class AnimationViewController: UIViewController {
	
	var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black
		
		animationView = .init(name: "plane")
		animationView?.frame = view.bounds
		animationView?.loopMode = .loop
		animationView?.animationSpeed = 0.9
		view.addSubview(animationView!)
		animationView?.play()

    }
}
