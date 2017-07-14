//
//  CounterModelViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

// Delegate subscribed to by parent Coorindinator
protocol CounterViewModelDelegate: class
{
    func homeViewModelNaviagateToHomeNavScene(viewController: UIViewController)
}

class CounterViewModel
{
    weak var delegate: CounterViewModelDelegate?
    weak var viewController: CounterViewController?
    
    func navigateToHomeNavScene(){
        delegate?.homeViewModelNaviagateToHomeNavScene(viewController: self.viewController!)
    }

}
