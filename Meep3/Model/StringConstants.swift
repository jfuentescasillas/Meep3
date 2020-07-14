//
//  StringConstants.swift
//  Meep3
//
//  Created by Jorge Fuentes Casillas on 09/07/20.
//  Copyright © 2020 Jorge Fuentes Casillas. All rights reserved.
//

import Foundation


struct StringConstants {
	// Constants used in ViewController
	let kAPIKey: String = "AIzaSyBjlsW5cmDOHZUqI2Ufcs-WeN2S0i5-omo"
	let kUrlAPIGlobal: URL! = URL(string: "https://apidev.meep.me/tripplan/api/v1/routers/lisboa/resources?lowerLeftLatLon=38.711046,-9.160096&upperRightLatLon=38.739429,-9.137115")
	let kAccessLocationTitle: String = "We need access to your location"
	let kAccessLocationMessage: String = "In order to show you the services near your current location."
	let kPermissionDeniedTitle: String = "Permission to know your location is required"
	let kPermissionDeniedMessage: String = "Your location is needed to detect the services near you. You can allow the permission to use your location from Settings>Meep>Location and select \"When using the app\""
	let kPermissionRestrictedTitle: String = "The permission was restricted"
	let kPermissionRestrictedMessage: String = "In order to detect the services near you, we need to know your current location"
	let kLocationNotRetrievedTitle: String = "Impossible to retrieve location"
	let kLocationNotRetrievedMessage: String = "Something went wrong while retrieving location"
	
	// Messages used when api is being fetched
	let kFailedJSONProcessing: String = "JSON processing failed."
	let kFailedJSONSerialization: String = "Error while serializing JSON:"
}
