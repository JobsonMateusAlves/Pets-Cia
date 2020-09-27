//
//  DAO.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

protocol DAO {
    associatedtype T: Object
    
    var realm: Realm { get }
    
    func save(object: T, update: Realm.UpdatePolicy)
    func get() -> [T]
    func getReference(by id: Any?) -> T?
    func delete()
    func autoIncrementId(of object: T)
    
    func setAutoIncrement(of object: T, with id: Any)
}


extension DAO {
    
    //MARK: Save methods
    func save(object: T, update: Realm.UpdatePolicy = .all) {
        
        self.autoIncrementId(of: object)
        
        try? self.realm.write {
            self.realm.add(object, update: update)
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
        
        // Realm não possui auto-increment por padrão
        // Para criar é necessário uma informação que apenas a DAO tem acesso
        // DAO<T: Object> é genérica portanto com T não é possível ter acesso ao atributo id
        self.setAutoIncrement(of: object, with: (realm.objects(T.self).max(ofProperty: T.primaryKey() ?? "") as Int? ?? 0) + 1)
    }
}
