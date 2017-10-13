//
//  ViewController.swift
//  fotowalkers
//
//  Created by Marcel on 07.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import UIKit
import Mapbox

class MainViewController: UIViewController, MGLMapViewDelegate {
	var mapView: MGLMapView?

	override func viewDidLoad() {
		super.viewDidLoad()

		mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.streetsStyleURL())
		if let mv = mapView {
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

	func setupBuildingExtrusionLayer(_ mapView: MGLMapView, style: MGLStyle) {
		// Access the Mapbox Streets source and use it to create a `MGLFillExtrusionStyleLayer`. The source identifier is `composite`. Use the `sources` property on a style to verify source identifiers.
		if let source = style.source(withIdentifier: "composite") {
			let layer = MGLFillExtrusionStyleLayer(identifier: "buildings", source: source)
			layer.sourceLayerIdentifier = "building"

			// Filter out buildings that should not extrude.
			layer.predicate = NSPredicate(format: "extrude == 'true' AND height >= 0")

			// Set the fill extrusion height to the value for the building height attribute.
			layer.fillExtrusionHeight = MGLStyleValue(interpolationMode: .identity, sourceStops: nil, attributeName: "height", options: nil)
			layer.fillExtrusionBase = MGLStyleValue(interpolationMode: .identity, sourceStops: nil, attributeName: "min_height", options: nil)
			layer.fillExtrusionOpacity = MGLStyleValue(rawValue: 0.75)
			layer.fillExtrusionColor = MGLStyleValue(rawValue: .white)

			// Insert the fill extrusion layer below a POI label layer. If you aren’t sure what the layer is called, you can view the style in Mapbox Studio or iterate over the style’s layers property, printing out each layer’s identifier.
			if let symbolLayer = style.layer(withIdentifier: "poi-scalerank3") {
				style.insertLayer(layer, below: symbolLayer)
			} else {
				style.addLayer(layer)
			}
		}
	}

	func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
		setupBuildingExtrusionLayer(mapView, style: style)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "NewSpotLocationSegue" {
			let dst = (segue.destination as! UINavigationController).topViewController as! NewSpotLocationViewController
			dst.startLocation = mapView?.centerCoordinate
			dst.startZoomLevel = mapView?.zoomLevel
			dst.startDirection = mapView?.direction
			dst.completion = { (spotInfo: SpotInfo) -> Void in
				self.addMarker(title: spotInfo.name!, subtitle: "", location: spotInfo.location!)
			}
		}
	}
}

