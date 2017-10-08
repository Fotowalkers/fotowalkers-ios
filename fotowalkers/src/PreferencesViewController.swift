//
//  PreferencesViewController.swift
//  fotowalkers
//
//  Created by Marcel on 08.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import UIKit
import Mapbox

class PreferencesViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		// TODO fetch current settings
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	@IBAction func onDone(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
}
