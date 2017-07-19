//
//  CounterModelViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation

import RxSwift // Binding ViewModel to ViewController : Variable<Type>
import RxCocoa // Allows use of .map functionality

import RealmSwift // Allows access to presistent data stored in realm database
// Binding examples: // https://github.com/RxSwiftCommunity/RxRealm
import RxRealm // Binding Model to ViewModel : allows for Observerablility on realm data types





// Delegate subscribed to by parent Coorindinator
protocol CounterViewModelDelegate: class
{
    func homeViewModelNaviagateToHomeNavScene(viewController: UIViewController)
}

class CounterViewModel : NSObject
{
    weak var delegate: CounterViewModelDelegate?
    weak var viewController: CounterViewController?
    
    let realm : Realm
    
    var model: CounterModel
    
    var count = Variable<String>("-1")
   
    
    override init()
    {
        realm = try! Realm()

        model = CounterModelUntility().fetchCounterModel(_id: "userSettings", realm: realm)
        
        
        _ = Observable.from(object: model)
            .map { model -> String in
                return String(model.count)
            }
            .bindTo(count)
    }
    
    
    func navigateToHomeNavScene(){
        delegate?.homeViewModelNaviagateToHomeNavScene(viewController: self.viewController!)
    }
    
    func incrimentCounter(){
        
        // update model
        try! realm.write {
            model.count += 1
        }
        
    }
    
    func decrimentCounter(){
        
        

    }

}
