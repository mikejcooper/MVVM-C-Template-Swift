//
//  SettingsModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewModelDelegate: class
{

}

struct SettingsViewModel
{
    weak var delegate: SettingsViewModelDelegate?
    weak var viewController: SettingsViewController?
    
    
}

