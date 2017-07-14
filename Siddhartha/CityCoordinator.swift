//
//  CityCoordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

protocol CityCoordinatorDelegate: HandleSegueDelegate {
    
}

class CityCoordinator: Coordinator {
    
    var window: UIWindow
    weak var delegate: CityCoordinatorDelegate?
    
    
    var selectedCity: City?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "City", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? CityListViewController {
            var viewModel =  CityListViewModel.init()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
            let nav = UINavigationController.init(rootViewController: vc)
            window.rootViewController = nav
        }
    }
    
    // Function called from parent coordinator for custom navigation flow  i.e. allows access to a view within a specific storyboard from anywhere else in the app using callbacks to AppCoordinator and then from AppCoordinator to child view. 
    func presentRandomCity() {
        let storyboard = UIStoryboard(name: "City", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CityItem") as? CityItemViewController,
            let nav = window.rootViewController
        {
            let viewModel =  CityItemViewModel.init(city: Cities().randomCity())
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let CityItemNav = UINavigationController.init(rootViewController: vc)
            nav.present(CityItemNav, animated: true, completion: nil)
        }
    }
}


// Navigation from PARENT
extension CityCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityListScene" {
            let vc = segue.destination as! CityListViewController
            var viewModel =  CityListViewModel.init()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
    }
}

// Navigation from CHILD
extension CityCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityItemScene" {
            let dest = segue.destination as! CityItemViewController
            var viewModel = CityItemViewModel.init(city: selectedCity!)
            dest.viewModel = viewModel
            viewModel.delegate = self
            dest.coordinationDelegate = self
        }
    }
}




// ------------------------------- ViewModel Delegates --------------------------------------------------


extension CityCoordinator: CityListViewModelDelegate {
    func selectCity(viewController: UIViewController , city: City) {
        selectedCity = city
        viewController.performSegue(withIdentifier: "showCityItemScene", sender: viewController)
    }
}

extension CityCoordinator: CityItemViewModelDelegate {
    
}
