//
//  HomeViewModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: class
{
    func homeViewModelDidSelectGoToCityList(viewController: UIViewController)
    func homeViewModelDidSelectGoToRandomCity()
    func homeViewModelNaviagateToScreenAScene(viewController: UIViewController)
}

class HomeViewModel
{
    weak var delegate: HomeViewModelDelegate?
    weak var viewController: HomeViewController?
    
    func didSelectGoToCityList(){
        delegate?.homeViewModelDidSelectGoToCityList(viewController: self.viewController!)
    }
    
    func didSelectGoToRandomCity(){
        delegate?.homeViewModelDidSelectGoToRandomCity()
    }
    
    func navigateToScreenAScene(){
        delegate?.homeViewModelNaviagateToScreenAScene(viewController: self.viewController!)
    }
}

