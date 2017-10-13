//
//  PreciseLocationViewController.swift
//  fotowalkers
//
//  Created by Marcel on 10.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import UIKit
import Mapbox

class NewSpotLocationViewController: UIViewController {
	var mapView: MGLMapView?
	var startLocation: CLLocationCoordinate2D?
	var startZoomLevel: Double?
	var startDirection: CLLocationDirection?

	override func viewDidLoad() {
		super.viewDidLoad()

		mapView = MGLMapView()
		if let mv = mapView {
			mv.frame = view.bounds
			mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			mv.showsUserHeadingIndicator = true
			mv.showsUserLocation = true
			mv.setUserTrackingMode(MGLUserTrackingMode.none, animated: false)

			if let sl = startLocation {
				mv.setCenter(sl, animated: false)
			}
			if let szl = startZoomLevel {
				mv.setZoomLevel(szl, animated: false)
			}
			if let sd = startDirection {
				mv.setDirection(sd, animated: false)
			}
			
			view.addSubview(mv)
			view.sendSubview(toBack: mv) // Avoid overlaying controls defined in IB
		}
	}

	@IBAction func onCancel(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "NewSpotNameSegue" {
			let dst = segue.destination as! NewSpotNameViewController
			dst.spotInfo = SpotInfo()
			dst.spotInfo?.location = mapView?.centerCoordinate
		}
	}
}
