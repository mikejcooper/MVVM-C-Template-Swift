//
//  ScreenAModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

protocol ScreenAViewModelDelegate: class
{
//    func homeViewModelDidSelectGoToCityList(viewController: UIViewController)
//    func homeViewModelDidSelectGoToRandomCity()
    func homeViewModelNaviagateToGuideScene(viewController: UIViewController)
}

struct ScreenAViewModel
{
    weak var delegate: ScreenAViewModelDelegate?
    weak var viewController: ScreenAViewController?
    
    
    
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

