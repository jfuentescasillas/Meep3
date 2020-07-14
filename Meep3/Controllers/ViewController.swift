//
//  ViewController.swift
//  Meep3
//
//  Created by Jorge Fuentes Casillas on 09/07/20.
//  Copyright © 2020 Jorge Fuentes Casillas. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController {
	// MARK: Properties
	let stringConstants = StringConstants()
	let locationManager = CLLocationManager()
	var centerMapCoordinate: CLLocationCoordinate2D!
	var userLat: Double? // User's Latitude
	var userLon: Double? // User's Longitude
	let zoom: Float = 15.0  // Camera's zoom
	var arrayLat: [Double] = [] // Vehicle's Latitude
	var arrayLon: [Double] = [] // Vehicle's Longitude
	var arrayModelName: [String] = []
	var arrayName: [String] = []
	var arrayBattLvl = [Int]()
	var arrayHelmets = [Int]()
	var arrayBikesAvailable = [Int]()
	var arrayCompanyZoneID = [Int]()
	var uniqueCompanyZoneID = [Int]()
	
	// MARK: Elements in storyboard
	@IBOutlet var googleMap: GMSMapView!
	
	
	// MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		checkLocationServices()
		getAPI()
	}
}


// MARK: - Extension: Location Manager
extension ViewController: CLLocationManagerDelegate {
	// MARK: - Asking for permission to use user's location
	func checkLocationServices() {
		if CLLocationManager.locationServicesEnabled() {
			setupLocationManager()
			checkLocationAuthorization()
		} else {
			createAlert(title: stringConstants.kAccessLocationTitle,
						message: stringConstants.kAccessLocationMessage)
		}
	}
	
	
	func setupLocationManager() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.startMonitoringSignificantLocationChanges()		
	}
	
	
	func checkLocationAuthorization() {
		switch CLLocationManager.authorizationStatus() {
		case .authorizedWhenInUse:
			locationManager.startUpdatingLocation()
			
		case .denied:
			createAlert(title: stringConstants.kPermissionDeniedTitle,
						message: stringConstants.kPermissionDeniedMessage)
			
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
			
		case .restricted:
			createAlert(title: stringConstants.kPermissionRestrictedTitle,
						message: stringConstants.kPermissionRestrictedMessage)
			
		case .authorizedAlways:
			locationManager.startUpdatingLocation()
			
		@unknown default:
			break
		}
	}
	
	
	// MARK: - LocationManagerDelegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		// Obtain the user's location (latitude and longitude)
		guard let location = locations.first else {
			createAlert(title: stringConstants.kLocationNotRetrievedTitle,
						message: stringConstants.kLocationNotRetrievedMessage)
			return
		}
		
		userLat = location.coordinate.latitude
		userLon = location.coordinate.longitude
		
		centerMapCoordinate = CLLocationCoordinate2D(latitude: userLat ?? 0.0,
													 longitude: userLon ?? 0.0)
		
		showUserPosition(userLat: userLat ?? 0.0, userLon: userLon ?? 0.0)
	}
	
	
	// MARK: - show the user's location in the map method
	func showUserPosition(userLat: Double, userLon: Double) {
		googleMap.delegate = self
		self.googleMap.isMyLocationEnabled = true // User's current position (blue dot on the map)
		
		let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLon, zoom: zoom)
		googleMap.camera = camera
	}
	
	
	// MARK: - Alerts
	func createAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
			alert.dismiss(animated: true, completion: nil)
		}))
		
		self.present(alert, animated: true, completion: nil)
	}
}


// MARK: - Extension: GMSMapViewDelegate
extension ViewController: GMSMapViewDelegate {
	// MARK: - Call the api method
	func getAPI() {
		// API Parsing starts
		guard let urlAPI = stringConstants.kUrlAPIGlobal else { return }
		
		fetchAPI(url: urlAPI)
	}
	
	
	// MARK: - Fetching API from URL.
	func fetchAPI(url: URL) {
		let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
			if error == nil {
				guard let urlContent = data else { return }
				
				do {
					let JSONResult = try JSONDecoder().decode([MeepAPI].self, from: urlContent)
//					print("JSON Result:", JSONResult)
					
					for jsonData in JSONResult {
						self.arrayLon.append(jsonData.x)
						self.arrayLat.append(jsonData.y)
						self.arrayCompanyZoneID.append(jsonData.companyZoneId)
						self.arrayName.append(jsonData.name)
						self.arrayModelName.append(jsonData.model ?? "No Model")
						self.arrayBattLvl.append(jsonData.batteryLevel ?? 0)
						self.arrayBikesAvailable.append(jsonData.bikesAvailable ?? 0)
						self.arrayHelmets.append(jsonData.helmets ?? 0)
					}
					
					self.uniqueCompanyZoneID = self.arrayCompanyZoneID.removingDuplicates()
					
					print("-----------------")
					print("ArrayLon:", self.arrayLon)
					print("ArrayLat:", self.arrayLat)
					print("companyZoneId: ", self.arrayCompanyZoneID)
					print("Count zoneid: ", self.arrayCompanyZoneID.count)
					print("UniqueCompanyZoneId: ", self.uniqueCompanyZoneID)
					print("Count UniqueZoneId: ", self.uniqueCompanyZoneID.count)
					print("Bikes available: ", self.arrayBikesAvailable)
					print("-----------------")
					
					// MARK: - Place the multiple markers on the map with different random colors. One color per each companyZoneId
					var colors = [UIColor]()
					
					for _ in 0..<self.uniqueCompanyZoneID.count {
						colors.append(UIColor.random)
					}
					
					// As URLSession.shared.dataTask callback is in a background thread, we use DispatchQueue.main.async, otherwise the app crashes and we get in console: 'The API method must be called from the main thread'
					DispatchQueue.main.async {
						for index in 0..<self.arrayCompanyZoneID.count {
							let marker = GMSMarker()
							marker.position = CLLocationCoordinate2D(latitude: self.arrayLat[index],
																	 longitude: self.arrayLon[index])
							marker.title = "Name: \(self.arrayName[index])"
							marker.snippet = "Model: \(self.arrayModelName[index]), Battery level: \(self.arrayBattLvl[index]), Bikes available: \(self.arrayBikesAvailable[index]), Helmets: \(self.arrayHelmets[index])" // , CompanyID: \(self.arrayCompanyZoneID[index])
							marker.map = self.googleMap
							
							// Assigning the color to the marker in function to the companyZoneId
							for element in 0..<self.uniqueCompanyZoneID.count {
								if self.arrayCompanyZoneID[index] == self.uniqueCompanyZoneID [element] {
									marker.icon = GMSMarker.markerImage(with: colors[element])
								}
							}
						}
					}
					
				} catch {
					print(self.stringConstants.kFailedJSONProcessing)
				}
			} else {
				print(self.stringConstants.kFailedJSONSerialization, error?.localizedDescription as Any)
			}
		}
		
		task.resume()
	}
}
