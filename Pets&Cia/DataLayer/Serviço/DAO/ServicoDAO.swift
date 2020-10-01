//
//  ServicoDAO.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift


class ServicoDAO: DAO{
    
    typealias T = Servico
    var realm: Realm
    
    public init(realm: Realm){
        self.realm = realm
    }
    
    func update(object: Servico, id: Any) {
        
        let result = self.getReference(by: id)
        
        try? self.realm.write{
            result?.set(nome: object.nome)
            result?.set(descricao: object.descricao)
            result?.set(valor: object.valor.value)
        }
    }
    
    func setAutoIncrement(of object: Servico, with id: Any) {
        
        object.id.value = id as? Int
    }    
}
