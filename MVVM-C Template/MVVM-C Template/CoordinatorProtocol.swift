//
//  Coordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

protocol Coordinator: class
{
    func start()
}

protocol HandleSegueDelegate: class {
    func handleSegue(segue: UIStoryboardSegue)
}

protocol CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue)
}

protocol Coordinated {
    var coordinationDelegate: CoordinationDelegate? { get set }
}

