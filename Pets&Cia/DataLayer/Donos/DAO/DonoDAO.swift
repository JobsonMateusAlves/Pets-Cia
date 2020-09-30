//
//  DonoDAO.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

//Padrão Polimorfismo?
class DonoDAO: DAO {
    typealias T = Dono
    
    var realm: Realm
    
    //MARK: Inits
    public init(realm: Realm) {
        self.realm = realm
    }
    
    //MARK: Update
    func update(object: Dono, id: Any) {
        
        let result = self.getReference(by: id)
        
        try? self.realm.write {
            
            result?.set(nome: object.nome!)
            result?.set(email: object.email!)
            result?.set(numeroTelefone: object.numeroTelefone!)
            result?.set(endereco: object.endereco!)
        }
    }
    
    func setAutoIncrement(of object: Dono, with id: Any) {
        object.id.value = id as? Int
    }
}
