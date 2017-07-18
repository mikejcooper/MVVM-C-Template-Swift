//
//  CounterModelViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RealmSwift





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
    
    var count = Variable<String>("0")
    var persistentLabel = Variable<String>("0")
   
    private var notificationToken: NotificationToken?

    
     var updateME = Variable<String>("0")

    
    init(requiredModel: CounterModel)
    {
        self.model = requiredModel
        realm = try! Realm()
        
        count.value = String(model.count)
        persistentLabel.value = model.persitentData
        
    }
    
    func start(){
        let predicate = NSPredicate(format: "id = %@", "userSettings")
        let model1 = self.realm.objects(CounterModel.self).filter(predicate).first!
        notificationToken = model1.addNotificationBlock { change in
            switch change {
            case .initial(let updated_model):
                self.updateME.value = String(updated_model.count)
            case .update(let updated_model, _, _, _):
                self.updateME.value = String(updated_model.count)
            case .error(let error):
                print(error)
            }
        }
    }
    
    
    
    func navigateToHomeNavScene(){
        delegate?.homeViewModelNaviagateToHomeNavScene(viewController: self.viewController!)
    }
    
    func incrimentCounter(){
        print(updateME.value)
        
        // update model
        try! realm.write {
            model.count += 1
        }
        
        //update view model 
        count.value = String(model.count)
        
        print(count.value)

    }
    
    func decrimentCounter(){
        try! realm.write {
            model.count -= 1
        }
        
        count.value = String(model.count)
        print(count)
        
        

    }

}
