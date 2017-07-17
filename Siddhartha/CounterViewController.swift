//
//  CounterViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//


import Foundation
import UIKit

class CounterViewController: UIViewController, Coordinated
{
    var viewModel: CounterViewModel?
    var coordinationDelegate: CoordinationDelegate?
    
    
    override func viewDidLoad(){
    }
    
    
    @IBAction func startAppAgainButtonClicked(_ sender: UIButton) {
        viewModel?.navigateToHomeNavScene()
    }

    
}
