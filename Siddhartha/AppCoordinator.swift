//
//  AppCoordinator.swift
//  Siddhartha
//
//  Created by Mike Cooper on 13/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator
{
    // Array indexes for coordinators array
    fileprivate let kHomeCoordinator: String  = "kHomeCoordinator"
    fileprivate let kCityCoordinator: String  = "kCityCoordinator"
    fileprivate let kCounterCoordinator: String  = "kCounterCoordinator"
    
    var window: UIWindow
    var coordinators = [String: Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = window        
        UIViewController.addCoordination()
    }
    
    func start()
    {
        goToHome()
    }
    
    func goToHome() {
        let homeCoordinator = HomeCoordinator(window: window)
        coordinators[kHomeCoordinator] = homeCoordinator
        homeCoordinator.delegate = self
        homeCoordinator.start()
    }
    
}


//  ----------------------------------------------- Delegates --------------------------------------------------


// --------------------- Naviagtion HandleSegue Delegates ------------------

extension AppCoordinator: HandleSegueDelegate
{
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityListScene" {
            let cityCoordinator = CityCoordinator(window: window)
            coordinators[kCityCoordinator] = cityCoordinator
            cityCoordinator.delegate = self
            
            // There are two options here, handleSegue (like below) or .start() like in 'showCounterScene'
            cityCoordinator.handleSegue(segue: segue)
            // start method of Coodinator sets rootViewController therefore previous navigation flow will be reset i.e. back button from pop segue will not appear. 
        }
        if segue.identifier == "showCounterScene" {
            let counterCoordinator = CounterCoordinator(window: window)
            coordinators[kCounterCoordinator] = counterCoordinator
            counterCoordinator.delegate = self
            counterCoordinator.start()
        }
        
        if segue.identifier == "showHomeNavScene" {
            let homeCoordinator = HomeCoordinator(window: window)
            coordinators[kHomeCoordinator] = homeCoordinator
            homeCoordinator.delegate = self
            homeCoordinator.start()
        }

    }
}


// --------------------- Delegates Per Coordinator ------------------

extension AppCoordinator: HomeCoordinatorDelegate
{
    func naviagateToRandomCityScene()
    {
        let cityCoordinator = CityCoordinator(window: window)
        coordinators[kCityCoordinator] = cityCoordinator
        cityCoordinator.delegate = self
        cityCoordinator.presentRandomCity()
    }
}


extension AppCoordinator: CityCoordinatorDelegate
{
    
}

extension AppCoordinator: CounterCoordinatorDelegate
{
    
}



// ------------------------------------- Coordinator Queue Segue Code -------------------------------------------

extension UIViewController {
    
    class func addCoordination() {
        DispatchQueue.once(token: "com.test.test1") {
            let originalPerformSelector = #selector(UIViewController.prepare(for:sender:))
            let swizzledPerformSelector = #selector(swizzledPrepare(for:sender:))
            
            method_exchangeImplementations(class_getInstanceMethod(UIViewController.self, originalPerformSelector),
                                           class_getInstanceMethod(UIViewController.self, swizzledPerformSelector))
        }
    }
    
    func swizzledPrepare(for segue: UIStoryboardSegue,sender: Any?) {
        defer {
            self.swizzledPrepare(for: segue, sender: self)
        }
        
        guard let sourceViewController = segue.source as? Coordinated else {
            return
        }
        
        sourceViewController.coordinationDelegate?.prepareForSegue(segue: segue)
        
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

