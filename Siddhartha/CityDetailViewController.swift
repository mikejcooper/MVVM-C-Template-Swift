//
//  CityItemViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

class CityItemViewController: UIViewController, Coordinated {
    var coordinationDelegate: CoordinationDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var viewModel: CityItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel?.name
        dataLabel.text = viewModel?.data
        
        if (navigationController?.viewControllers.count)! == 1 {
            let closeButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(dismissFromParent))
            navigationItem.leftBarButtonItem = closeButton
        }
    }
    
    func dismissFromParent() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
