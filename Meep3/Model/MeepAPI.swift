//
//  MeepAPI.swift
//  Meep3
//
//  Created by Jorge Fuentes Casillas on 09/07/20.
//  Copyright © 2020 Jorge Fuentes Casillas. All rights reserved.
//

import Foundation


// MARK: - Elements from the API
struct MeepAPI: Codable {
	let id: String
	let name: String
	let x: Double // Longitude
	let y: Double // Latitude
	let licencePlate: String?
	let range: Int?
	let batteryLevel: Int?
	let seats: Int?
	let model: String?
	let resourceImageId: String?
	let pricePerMinuteParking: Int?
	let pricePerMinuteDriving: Int?
	let realTimeData: Bool?
	let engineType: String?
	let resourceType: String?
	let companyZoneId: Int
	let helmets: Int?
	let station: Bool?
	let availableResources: Int?
	let spacesAvailable: Int?
	let allowDropoff: Bool?
	let bikesAvailable: Int?
}
