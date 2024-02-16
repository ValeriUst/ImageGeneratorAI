//  NetworkAPI.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation

struct ConstantsAPI {
	static let API_KEY = "TouFyL4VyhWWNhqC3DnF5hAdR2fLXxgGY4Gpe4BqC8YGKE2j4NjuNrJAXetE"
	static let baseURL = "https://stablediffusionapi.com/api/v3/text2img"
}

enum APIError: Error {
	case failedToGetData
	case invalidURL
	case failedToDecodeData
}

final class APICaller {
	static let shared = APICaller()
	
	func sendPostRequest(searchText: String, completion: @escaping (Result<ImageModel, Error>) -> Void) {
		guard let url = URL(string: ConstantsAPI.baseURL) else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		let requestData: [String: Any] = [
			"key": ConstantsAPI.API_KEY,
			"prompt": searchText,
			"width": "768",
			"height": "1024",
			"samples": "1",
			"enhance_prompt": "yes",
			"self_attention": "yes",
		]
		
		guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
			completion(.failure(APIError.failedToGetData))
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = jsonData
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(APIError.failedToGetData))
				return
			}
			do {
				let decoder = JSONDecoder()
				let imageModel = try decoder.decode(ImageModel.self, from: data)
				completion(.success(imageModel))
			} catch {
				completion(.failure(APIError.failedToDecodeData))
			}
		}
		task.resume()
	}
}
