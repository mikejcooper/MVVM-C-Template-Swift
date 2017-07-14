//
//  TestController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

class ScreenAViewController: UIViewController, Coordinated
{
//    @IBOutlet weak var pickCityButton: UIButton!
//    @IBOutlet weak var randomPickCityButton: UIButton!
    
    var viewModel: ScreenAViewModel?
    var coordinationDelegate: CoordinationDelegate?
    
    override func viewDidLoad(){
        
    }

    
    @IBAction func BackwardsButtonClicked(_ sender: UIButton) {
        viewModel?.navigateToGuideScene()
    }
    
    
//    @IBAction func pickCityButtonClicked(_ sender: Any) {
//        print("testController")
//    }
//
//    @IBAction func randomPickButtonClicked(_ sender: Any) {
//        viewModel?.didSelectGoToRandomCity()
//    }
}
