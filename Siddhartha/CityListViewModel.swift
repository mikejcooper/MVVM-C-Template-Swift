//
//  CityListViewModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

protocol CityListViewModelDelegate: class
{
    func selectCity(viewController: UIViewController, city: City)
}

struct CityListViewModel {
    var delegate: CityListViewModelDelegate?
    weak var viewController: CityListViewController!
    var source = [String]()
    
    init() {
        for city in cities {
            source.append(city.name)
        }
    }
    
    func selectRow(row: NSInteger) {
        delegate?.selectCity(viewController: viewController, city: cities[row])
    }
    
    fileprivate var cities: [City] {
        get {
            return Cities().cities()
        }
    }
}
