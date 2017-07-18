//
//  CityItemViewModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation

protocol CityItemViewModelDelegate: class
{
}

struct CityItemViewModel {
    weak var delegate: CityItemViewModelDelegate?
    var name: String!
    var data: String!
    
    init(city: City) {
        self.name = city.name
        self.data = city.data
    }
    
}
