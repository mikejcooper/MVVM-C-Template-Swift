//
//  CounterModel.swift
//  Siddhartha
//
//  Created by Mike Cooper on 17/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class CounterModel : Object{
    
    dynamic var count : Int = 0
    dynamic var persitentData : String = ""
    
    
    dynamic var id : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}








struct CounterModelUntility {
    
    func fetchCounterModel(_id: String, realm: Realm) -> CounterModel {
        var model : CounterModel? = doesCounterModelExist(_id: _id, realm: realm)
        // If first time in App
        if(model == nil){
            model = CounterModel()
            model?.id = _id
            try! realm.write {
                realm.add(model!)
            }
        }
        return model!
    }
    
    func removeCounterModel(_id: String, realm: Realm) {
        let model : CounterModel? = doesCounterModelExist(_id: _id, realm: realm)
        if(model != nil){
            try! realm.write {
                realm.delete(model!)
            }
        }
    }
    
    func doesCounterModelExist(_id: String, realm: Realm) -> CounterModel?{
        let predicate = NSPredicate(format: "id = %@", _id)
        let object = realm.objects(CounterModel.self).filter(predicate).first
        if object?.id == _id {
            return object
            
        }
        return nil
    }
    

}
