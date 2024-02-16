//  ModelImages.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation

// MARK: - Welcome
struct ImageModel: Codable {
	let output: [String]?
	
	enum CodingKeys: String, CodingKey {
		case output
	}
}
