//
//  AnimalUseCases.swift
//  Pets&Cia
//
//  Created by ALICE LINS CARNEIRO MALZAC on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

//Padrão Singleton
//Padrão Observer
import Foundation
import RealmSwift

class AnimalUseCases: UseCases {
                                          
    typealias T = Animal
    
    static let shared: AnimalUseCases = {
        return AnimalUseCases()
    }()
    
    var dao: AnimalDAO?
    var observers: [Observer] = []
    
    private init() {}
    
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
    
    func listar(by donoId: Any) -> [Animal] {
        self.dao?.get(by: donoId) ?? []
    }
    
    func add(servico: String, id: Any?) {
        if let id = id {
            self.dao?.addServicoToHistorico(servico: servico, id: id)
            self.notify()
        }
    }
}

extension AnimalUseCases: Subject {
    
    func remove(observer: Observer?) {  
        if let observer = observer {
            self.observers.removeAll(where: { $0 as? UIViewController === observer as? UIViewController })
        }
    }
}
