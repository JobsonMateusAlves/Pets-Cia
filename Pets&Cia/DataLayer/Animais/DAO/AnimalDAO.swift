//
//  AnimalDAO.swift
//  Pets&Cia
//
//  Created by ALICE LINS CARNEIRO MALZAC on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class AnimalDAO: DAO{
    
    typealias T = Animal
    var realm: Realm
    
    public init(realm: Realm){
        self.realm = realm
    }
    
    func update(object: Animal, id: Any) {
        
        let result = self.getReference(by: id)
        
        try? self.realm.write{
            result?.set(nome: object.nome!)
            result?.set(raca: object.raca!)
        }
    }
    
    func get(by donoId: Any) -> [Animal] {
        
        self.get().filter({ $0.donoId.value == donoId as? Int})
    }
    
    func addServicoToHistorico(servico: String, id: Any) {
        
        let result = self.getReference(by: id)
        
        try? self.realm.write{
            result?.set(historico: servico)
        }
    }
    
    func setAutoIncrement(of object: Animal, with id: Any) {
        
        object.id.value = id as? Int
    }
}
