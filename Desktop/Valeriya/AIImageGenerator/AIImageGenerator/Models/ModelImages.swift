//  ModelImages.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation

// MARK: - Welcome
struct ImageModel: Codable {
	let output: [String]?
	let meta: Meta?
	
	enum CodingKeys: String, CodingKey {
		case output
		case meta
	}
}

// MARK: - Meta
struct Meta: Codable {
	let h, w: Int?
	let nSamples: Int?

	enum CodingKeys: String, CodingKey {
		case h = "H"
		case w = "W"
		case nSamples = "n_samples"
	}
}
