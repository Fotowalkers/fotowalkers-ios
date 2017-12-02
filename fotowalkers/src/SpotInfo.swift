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
}
