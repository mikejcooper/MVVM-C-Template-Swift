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
        if let vc = storyboard.instantiateViewController(withIdentifier: "list") as? CityListViewController {
            var viewModel =  CityListViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            window.rootViewController = nav
        }
    }
    
    func presentRandomCity() {
        let storyboard = UIStoryboard(name: "City", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detail") as? CityDetailViewController,
            let nav = window.rootViewController
        {
            let viewModel =  CityDetailViewModel.init(city: Cities().randomCity())
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let cityDetailNav = UINavigationController.init(rootViewController: vc)
            nav.present(cityDetailNav, animated: true, completion: nil)
        }
    }
}

extension CityCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityList" {
            let vc = segue.destination as! CityListViewController
            var viewModel =  CityListViewModel.init()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
    }
}

extension CityCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showDetail" {
            let dest = segue.destination as! CityDetailViewController
            var viewModel = CityDetailViewModel.init(city: selectedCity!)
            dest.viewModel = viewModel
            viewModel.delegate = self
            dest.coordinationDelegate = self
        }
    }
}

extension CityCoordinator: CityListViewModelDelegate {
    func selectCity(viewController: UIViewController , city: City) {
        selectedCity = city
        viewController.performSegue(withIdentifier: "showDetail", sender: viewController)
    }
}

extension CityCoordinator: CityDetailViewModelDelegate {
    
}
