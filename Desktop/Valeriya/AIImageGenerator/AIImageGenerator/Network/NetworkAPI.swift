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
	
	func sendPostRequest(jsonData: Data, searchText: String, completion: @escaping (Result<String, Error>) -> Void) {
		guard let url = URL(string: ConstantsAPI.baseURL) else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		let requestData: [String: Any] = [
			"key": ConstantsAPI.API_KEY,
			"prompt": searchText,
			"width": "1024",
			"height": "1024",
			"samples": "1",
			"enhance_prompt": "yes",
			"self_attention": "yes",
		]
		
		guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData.compactMapValues { $0 }) else {
			completion(.failure(APIError.failedToGetData))
			return
		}
		
		if let jsonString = String(data: jsonData, encoding: .utf8) {
			print("Request Data: \(jsonString)") // Выводим содержимое запроса
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = jsonData
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
				completion(.failure(APIError.failedToGetData))
				return
			}
			do {
				let json = try JSONSerialization.jsonObject(with: data, options: [])
				guard let jsonDict = json as? [String: Any], let output = jsonDict["output"] as? [String], let imageURLString = output.first else {
					completion(.failure(APIError.failedToGetData))
					return
				}
				
				let imageURLStringWithoutEscapes = imageURLString.replacingOccurrences(of: "\\/", with: "/")
				completion(.success(imageURLStringWithoutEscapes))
			} catch {
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
}
