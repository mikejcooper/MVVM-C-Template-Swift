//
//  SettingsModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewModelDelegate: class
{
//    func homeViewModelDidSelectGoToCityList(viewController: UIViewController)
//    func homeViewModelDidSelectGoToRandomCity()
    func homeViewModelNaviagateToGuideScene(viewController: UIViewController)
}

struct SettingsViewModel
{
    weak var delegate: SettingsViewModelDelegate?
    weak var viewController: SettingsViewController?
    
    
    
//    func didSelectGoToCityList(){
//        delegate?.homeViewModelDidSelectGoToCityList(viewController: self.viewController!)
//    }
//    
//    func didSelectGoToRandomCity(){
//        delegate?.homeViewModelDidSelectGoToRandomCity()
//    }
//    
    func navigateToGuideScene(){
        delegate?.homeViewModelNaviagateToGuideScene(viewController: self.viewController!)
    }
}

