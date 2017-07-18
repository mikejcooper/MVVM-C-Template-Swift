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
    
    weak var counterModel: CounterModel?
    
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? CounterViewController {
            let viewModel =  CounterViewModel(requiredModel: counterModel!)
            viewModel.delegate = self
            viewModel.viewController = vc
            viewModel.start()
//            viewModel.model = counterModel
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            window.rootViewController = nav
        }
    }
    
    
}


// Navigation from PARENT
extension CounterCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        
    
    }
}

// Navigation from CHILD
extension CounterCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        
        if segue.identifier == "showHomeNavScene" {
            delegate?.handleSegue(segue: segue)
        }

    }
}


// ------------------------------- ViewModel Delegates --------------------------------------------------


extension CounterCoordinator: CounterViewModelDelegate {
    
    func homeViewModelNaviagateToHomeNavScene(viewController: UIViewController){
        viewController.performSegue(withIdentifier: "showHomeNavScene", sender: viewController)
    }
}



