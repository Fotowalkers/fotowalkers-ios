//
//  SpotInfo.swift
//  fotowalkers
//
//  Created by Marcel on 13.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import Foundation
import Mapbox

class SpotInfo : Codable {
	var title: String?
	var location: CLLocationCoordinate2D?

	enum CodingKeys: String, CodingKey {
		case title
		case latitude
		case longitude
	}

	struct SpotError : Error {
		enum ErrorKind {
			case invalidJson
		}

		var kind: ErrorKind
		var message: String
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		title = try container.decode(String.self, forKey: .title)
		location = CLLocationCoordinate2D()
		location?.latitude = try container.decode(Double.self, forKey: .latitude)
		location?.longitude = try container.decode(Double.self, forKey: .longitude)
	}

	required init() {
		title = nil
		location = nil
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(title, forKey: .title)
		try container.encode(location?.latitude, forKey: .latitude)
		try container.encode(location?.longitude, forKey: .longitude)
	}

	static func getAll(completion: @escaping ([SpotInfo], Error?) -> Void) {
		let session = URLSession(configuration: URLSessionConfiguration.default)
		let task = session.dataTask(with: Constants.ApiServerUrl) { (data: Data?, response: URLResponse?, error: Error?) in
			if let e = error {
				print("Error fetching spots: \(e.localizedDescription)")
				completion([], e)
				return
			}

			if let d = data {
				let decoder = JSONDecoder()
				do {
					var spotList: [SpotInfo]
					try spotList = decoder.decode([SpotInfo].self, from: d)
					completion(spotList, nil)
				} catch _ {
					let e = SpotError(kind: .invalidJson, message: "Invalid JSON received")
					print("Error decoding spots: \(e.message)")
					completion([], e)
				}
			}
		}
		task.resume()
	}
}
