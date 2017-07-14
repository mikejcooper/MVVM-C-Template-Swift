//
//  HomeCoordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: HandleSegueDelegate {
    func goToRandomCity()
}

class HomeCoordinator: Coordinator {
    
    var window: UIWindow
    weak var delegate: HomeCoordinatorDelegate?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let nav = storyboard.instantiateInitialViewController() as? UINavigationController {
            let vc = nav.viewControllers.first as! HomeViewController
            vc.test()
            var viewModel =  HomeViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            window.rootViewController = nav
        }
    }
}

extension HomeCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityList" {
            delegate?.handleSegue(segue: segue)
        }
        if segue.identifier == "HomeToSettings" {
            let vc = segue.destination as! SettingsViewController
            var viewModel =  SettingsViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self as? SettingsViewModelDelegate
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
        if segue.identifier == "SettingstoGuide" {
            
            let vc = segue.destination as! HomeViewController
            vc.test()
            var viewModel =  HomeViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
            
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            if let nav = storyboard.instantiateInitialViewController() as? UINavigationController {
//                let vc = nav.viewControllers.first as! HomeViewController
//                vc.test()
//                var viewModel =  HomeViewModel()
//                viewModel.viewController = vc
//                viewModel.delegate = self
//                vc.viewModel = viewModel
//                vc.coordinationDelegate = self
//            }

        }

    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    
    func homeViewModelDidSelectGoToCityList(viewController: UIViewController) {
        viewController.performSegue(withIdentifier: "showCityList", sender: viewController)
    }
    
    func homeViewModelDidSelectGoToRandomCity() {
        delegate?.goToRandomCity()
    }
    
    func homeViewModelNaviagateToSettingsScene(viewController: UIViewController){
//        viewController.performSegue(withIdentifier: "guideToSettings", sender: viewController)
    }
}

extension HomeCoordinator: SettingsViewModelDelegate {


    func homeViewModelNaviagateToGuideScene(viewController: UIViewController){
//        viewController.performSegue(withIdentifier: "SettingstoGuide", sender: viewController)
    }
}

