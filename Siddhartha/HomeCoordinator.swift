//
//  HomeCoordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: HandleSegueDelegate {
    func naviagateToRandomCityScene()
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


extension HomeCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
       
        if segue.identifier == "showHomeNavScene" {
            
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            if let nav = storyboard.instantiateInitialViewController() as? UINavigationController {
                let vc = nav.viewControllers.first as! HomeViewController
                vc.test()
                var viewModel =  HomeViewModel()
                viewModel.delegate = self
                viewModel.viewController = vc
                vc.viewModel = viewModel
                vc.coordinationDelegate = self
            }
        }
    }
}



extension HomeCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityListScene" {
            delegate?.handleSegue(segue: segue)
        }
        if segue.identifier == "showCounterScene" {
            delegate?.handleSegue(segue: segue)
        }
        if segue.identifier == "showSettingsScene" {
            let vc = segue.destination as! SettingsViewController
            var viewModel =  SettingsViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self as? SettingsViewModelDelegate
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
    }
}



extension HomeCoordinator: HomeViewModelDelegate {
    
    func homeViewModelNaviagateToCityListScene(viewController: UIViewController) {
        viewController.performSegue(withIdentifier: "showCityListScene", sender: viewController)
    }
    
    func homeViewModelNaviagateToRandomCityScene() {
        delegate?.naviagateToRandomCityScene()
    }
    
    func homeViewModelNaviagateToCounterScene(viewController: UIViewController){
        viewController.performSegue(withIdentifier: "showCounterScene", sender: viewController)
    }
}

extension HomeCoordinator: SettingsViewModelDelegate {

}

