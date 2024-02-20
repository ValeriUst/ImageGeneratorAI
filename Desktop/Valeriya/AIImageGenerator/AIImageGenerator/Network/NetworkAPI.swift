//  NetworkAPI.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation
import Alamofire

struct ConstantsAPI {
	static let API_KEY = "TouFyL4VyhWWNhqC3DnF5hAdR2fLXxgGY4Gpe4BqC8YGKE2j4NjuNrJAXetE"
	static let baseURL = "https://stablediffusionapi.com/api/v3/text2img"
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
		
		AF.request(url, method: .post, 
				   parameters: requestData,
				   encoding: JSONEncoding.default,
				   headers: ["Content-Type": "application/json"])
		
			.validate(statusCode: 200..<300)
		
			.responseDecodable(of: ImageModel.self) { response in
				switch response.result {
				case .success(let imageModel):
					completion(.success(imageModel))
				case .failure(_):
					completion(.failure(APIError.failedToGetData))
				}
			}
	}
}
