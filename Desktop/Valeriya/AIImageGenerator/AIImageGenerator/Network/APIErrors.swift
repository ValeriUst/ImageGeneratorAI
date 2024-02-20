//  APIErrors.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 20.02.2024.

import Foundation

enum APIError: Error {
	case failedToGetData
	case invalidURL
	case failedToDecodeData
}
