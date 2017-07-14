//
//  CounterCoordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

protocol CounterCoordinatorDelegate: HandleSegueDelegate {
    
}

class CounterCoordinator: Coordinator {
    
    var window: UIWindow
    weak var delegate: CounterCoordinatorDelegate?
    
        
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? CounterViewController {
            var viewModel =  CounterViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            window.rootViewController = nav
        }
    }
    
    
}

extension CounterCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        
        
        
//        if segue.identifier == "showCounterScene" {
//            let vc = segue.destination as! CounterViewController
//            var viewModel =  CounterViewModel.init()
//            viewModel.viewController = vc
//            viewModel.delegate = self
//            vc.coordinationDelegate = self
//            vc.viewModel = viewModel
//        }
    
    }
}

extension CounterCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        
        if segue.identifier == "showHomeNavScene" {
            delegate?.handleSegue(segue: segue)
        }
//        if segue.identifier == "showCounterDetailScene" {
//            let dest = segue.destination as! CounterDetailViewController
//            var viewModel = CounterDetailViewModel.init(Counter: selectedCounter!)
//            dest.viewModel = viewModel
//            viewModel.delegate = self
//            dest.coordinationDelegate = self
//        }
        
    }
}

extension CounterCoordinator: CounterViewModelDelegate {
    
    func homeViewModelNaviagateToHomeNavScene(viewController: UIViewController){
        viewController.performSegue(withIdentifier: "showHomeNavScene", sender: viewController)
    }
}



