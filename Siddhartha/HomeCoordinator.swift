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
        if segue.identifier == "guideToScreenA" {
            let vc = segue.destination as! ScreenAViewController
            var viewModel =  ScreenAViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self as? ScreenAViewModelDelegate
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
        if segue.identifier == "screenAtoGuide" {
            let vc = segue.destination as! HomeViewController
            var viewModel =  HomeViewModel()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
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
    
    func homeViewModelNaviagateToScreenAScene(viewController: UIViewController){
        viewController.performSegue(withIdentifier: "HomeToSettings", sender: viewController)
    }
}
