//
//  DAO.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

//Padrão DAO
//Padrão Invencao pura
//Padrão Indireção
//Padrão Template Method
protocol DAO {
    associatedtype T: Object
    
    var realm: Realm { get }
    
    func save(object: T)
    func update(object: T, id: Any)
    func get() -> [T]
    func getReference(by id: Any?) -> T?
    func delete()
    func autoIncrementId(of object: T)
    
    func setAutoIncrement(of object: T, with id: Any)
}


extension DAO {
    
    //MARK: Save methods
    func save(object: T) {
        
        self.autoIncrementId(of: object)
        
        try? self.realm.write {
            self.realm.add(object, update: .error)
        }
    }
    
    //MARK: Get methods
    func get() -> [T] {
        
        let results = self.realm.objects(T.self)
        
        var objects: [T] = []
        objects.append(contentsOf: results)
        
        return objects
    }
    
    func getReference(by id: Any?) -> T? {
        
        self.realm.object(ofType: T.self, forPrimaryKey: id)
    }
    
    func get(by id: Any?) -> T? {
        
        self.realm.object(ofType: T.self, forPrimaryKey: id)?.detached()
    }
    
    //MARK: Delete methods
    func delete() {
        try? self.realm.write {
            self.realm.delete(self.realm.objects(T.self))
        }
    }
    
    func delete(with id: Any) {
        if let object = self.getReference(by: id) {
            try? self.realm.write {
                self.realm.delete(object)
            }
        }
    }
    
    func autoIncrementId(of object: T) {
    
        self.setAutoIncrement(of: object, with: (realm.objects(T.self).max(ofProperty: T.primaryKey() ?? "") as Int? ?? 0) + 1)
    }
}
