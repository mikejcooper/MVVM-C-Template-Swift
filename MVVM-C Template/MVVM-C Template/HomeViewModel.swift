

import Foundation
import UIKit

// Delegate subscribed to by parent Coorindinator
protocol HomeViewModelDelegate: class
{
    func homeViewModelNaviagateToCityListScene(viewController: UIViewController)
    func homeViewModelNaviagateToRandomCityScene()
    func homeViewModelNaviagateToCounterScene(viewController: UIViewController)
}

class HomeViewModel
{
    weak var delegate: HomeViewModelDelegate?
    weak var viewController: HomeViewController?
    
    func navigateToCityListScene(){
        delegate?.homeViewModelNaviagateToCityListScene(viewController: self.viewController!)
    }
    
    func navigateToRandomCityScene(){
        delegate?.homeViewModelNaviagateToRandomCityScene()
    }
    
    func navigateToCounterScene(){
        delegate?.homeViewModelNaviagateToCounterScene(viewController: self.viewController!)
    }
}

