//
//  HomeController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, Coordinated
{
    @IBOutlet weak var pickCityButton: UIButton!
    @IBOutlet weak var randomPickCityButton: UIButton!
    
    var viewModel: HomeViewModel?
    var coordinationDelegate: CoordinationDelegate?
    
    
    override func viewDidLoad(){
    }
    
    
    @IBAction func pickCityButtonClicked(_ sender: Any) {
        viewModel?.navigateToCityListScene()
    }
    
    @IBAction func randomPickButtonClicked(_ sender: Any) {
        viewModel?.navigateToRandomCityScene()
    }
    
    @IBAction func counterButtonClicked(_ sender: Any) {
        viewModel?.navigateToCounterScene()
    }

}
