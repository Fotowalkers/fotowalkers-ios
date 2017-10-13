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
	var mapView: MGLMapView?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		mapView = MGLMapView()
		if let mv = mapView {
			mv.frame = view.bounds
			mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			mv.showsUserHeadingIndicator = true
			mv.showsUserLocation = true
			mv.setUserTrackingMode(MGLUserTrackingMode.follow, animated: true)
			mv.delegate = self
			view.addSubview(mv)
			view.sendSubview(toBack: mv) // Avoid overlaying controls defined in IB
		}

		// TODO 3d building extrusion layer

		// Prepare some dummy data
		addMarker(title: "Great Spot",
		          subtitle: "Take a photo here!",
		          location: CLLocationCoordinate2D(latitude: 53.557085, longitude: 9.993682))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addMarker(title: String, subtitle: String, location: CLLocationCoordinate2D) {
		let annotation = MGLPointAnnotation()
		annotation.coordinate = location
		annotation.title = title
		annotation.subtitle = subtitle
		mapView?.addAnnotation(annotation)
	}

	func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
		// Custom marker appearances go here
		return nil
	}

	func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
		// Enable callouts for all annotations for now
		return true
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "NewSpotLocationSegue" {
			let dst = (segue.destination as! UINavigationController).topViewController as! NewSpotLocationViewController
			dst.startLocation = mapView?.centerCoordinate
			dst.startZoomLevel = mapView?.zoomLevel
			dst.startDirection = mapView?.direction
		}
	}
}

