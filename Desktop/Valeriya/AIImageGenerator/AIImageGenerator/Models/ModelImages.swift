//  ModelImages.swift
//  AIImageGenerator
//  Created by Валерия Устименко on 14.02.2024.

import Foundation

// MARK: - Welcome
struct ImageModel: Codable {
	let output, proxyLinks: [String]
	let meta: Meta
	
	enum CodingKeys: String, CodingKey {
		case output
		case proxyLinks = "proxy_links"
		case meta
	}
}

// MARK: - Meta
struct Meta: Codable {
	let h, w: Int
	let enableAttentionSlicing, filePrefix: String
	let guidanceScale: Double
	let instantResponse, model: String
	let nSamples: Int
	let negativePrompt, outdir, prompt, revision: String
	let safetychecker: String
	let seed, steps: Int
	let temp, vae: String
	
	enum CodingKeys: String, CodingKey {
		case h = "H"
		case w = "W"
		case enableAttentionSlicing = "enable_attention_slicing"
		case filePrefix = "file_prefix"
		case guidanceScale = "guidance_scale"
		case instantResponse = "instant_response"
		case model
		case nSamples = "n_samples"
		case negativePrompt = "negative_prompt"
		case outdir, prompt, revision, safetychecker, seed, steps, temp, vae
	}
}
