//
//  NewSpotController.swift
//  fotowalkers
//
//  Created by Marcel on 08.10.17.
//  Copyright © 2017 Marcel Kummer. All rights reserved.
//

import UIKit

class NewSpotNameViewController: UITableViewController {
	@IBOutlet weak var nameTextField: UITextField!

	var spotInfo: SpotInfo?
	var completion: ((SpotInfo) -> Void)?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func onCancel(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func onSave(_ sender: Any) {
		if var si = spotInfo {
			// TODO validate input
			si.name = nameTextField.text!
			// TODO store locally, try to upload?
			completion?(si)
		}
		dismiss(animated: true, completion: nil)
	}
}
