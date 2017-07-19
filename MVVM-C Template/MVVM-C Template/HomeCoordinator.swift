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
        // Finds initial view controller attached to storyboard
        if let nav = storyboard.instantiateInitialViewController() as? UINavigationController {
            let vc = nav.viewControllers.first as! HomeViewController
            let viewModel =  HomeViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            window.rootViewController = nav
        }
    }
}

// Navigation from PARENT
extension HomeCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
       // Handles incoming segue requests (change scene) from PARENT Coordinator
    }
}


// Navigation from CHILD
extension HomeCoordinator: CoordinationDelegate {
    
    // Handles incoming segue requests (change scene) from child viewModelDelegates (below)
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityListScene" {
            // Parse segue requests to parent coordinator via delegate
            delegate?.handleSegue(segue: segue)
        }
        if segue.identifier == "showCounterScene" {
            delegate?.handleSegue(segue: segue)
        }
        if segue.identifier == "showSettingsScene" {
            // Handles segue requests locally. New scene must be container within current storyboard.
            let vc = segue.destination as! SettingsViewController
            var viewModel =  SettingsViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
    }
}


// ------------------------------- ViewModel Delegates --------------------------------------------------


extension HomeCoordinator: HomeViewModelDelegate {
    
    func homeViewModelNaviagateToCityListScene(viewController: UIViewController) {
        viewController.performSegue(withIdentifier: "showCityListScene", sender: viewController)
    }
    
    func homeViewModelNaviagateToRandomCityScene() {
        // Call custom delegate (initalised at top)
        delegate?.naviagateToRandomCityScene()
    }
    
    func homeViewModelNaviagateToCounterScene(viewController: UIViewController){
        viewController.performSegue(withIdentifier: "showCounterScene", sender: viewController)
    }
}

extension HomeCoordinator: SettingsViewModelDelegate {

}

