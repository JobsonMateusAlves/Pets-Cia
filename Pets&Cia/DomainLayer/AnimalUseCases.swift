//
//  AnimalUseCases.swift
//  Pets&Cia
//
//  Created by ALICE LINS CARNEIRO MALZAC on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class AnimalUseCases: UseCases {           //implementando o protocolo UseCases
                                          // Interaje com o DAO
    typealias T = Animal                 // T - um tipo associado ao protocolo
    
    static let shared: AnimalUseCases = {  // singleton - classe que faz o compartilhamento
        return AnimalUseCases()
    }()
    
    var dao: AnimalDAO?
    var observers: [Observer] = []
    
    private init() {}    // garante que nao consegue instanciar outro AnimalUseCases
    
    func set(dao: AnimalDAO) {
        self.dao = dao
    }
}


//MARK: UseCases Functions
extension AnimalUseCases {
    func cadastrar(object: Animal) {
        self.dao?.save(object: object)
        self.notify()
    }
    
    func atualizar(object: Animal, with id: Any) {
        
        self.dao?.update(object: object, id: id)
        self.notify()
    }
    
    func listar() -> [Animal] {
        self.dao?.get() ?? []
    }
    
    func remover(id: Any?) {
        if let id = id {
            self.dao?.delete(with: id)
            self.notify()
        }
    }
    
    func get(by id: Any?) -> Animal? {
        if let id = id {
            return self.dao?.get(by: id)
        }
        return nil
    }
}

extension AnimalUseCases: Subject {     // As classes que imp o subject vai ser obs
    
    func remove(observer: Observer?) {  //padrão Observer -
        if let observer = observer {
            self.observers.removeAll(where: { $0 as? UIViewController === observer as? UIViewController })
        }
    }
}
