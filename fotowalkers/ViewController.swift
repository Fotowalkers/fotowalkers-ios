//
//  ViewController.swift
//  fotowalkers
//
//  Created by Marcel on 07.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()

		let mapView = MGLMapView()
		mapView.frame = view.bounds
		//mapView.styleURL = MGLStyle.outdoorsStyleURL()
		mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		mapView.showsUserHeadingIndicator = true
		mapView.showsUserLocation = true
		mapView.setUserTrackingMode(MGLUserTrackingMode.follow, animated: true)
		mapView.delegate = self
		view.addSubview(mapView)
		view.sendSubview(toBack: mapView) // Avoid overlaying controls defined in IB

		// Prepare some dummy data
		addMarker(mapView,
		          title: "Great Spot",
		          subtitle: "Take a photo here!",
		          location: CLLocationCoordinate2D(latitude: 53.557085, longitude: 9.993682))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addMarker(_ mapView: MGLMapView, title: String, subtitle: String, location: CLLocationCoordinate2D) {
		let annotation = MGLPointAnnotation()
		annotation.coordinate = location
		annotation.title = title
		annotation.subtitle = subtitle
		mapView.addAnnotation(annotation)
	}

	func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
		// Custom marker appearances go here
		return nil
	}

	func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
		// Enable callouts for all annotations for now
		return true
	}
}

