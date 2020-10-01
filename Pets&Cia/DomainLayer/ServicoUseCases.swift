//
//  ServicoUseCases.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 28/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

//Padrão Singleton
//Padrão Observer
class ServicoUseCases: UseCases {

    typealias T = Servico
    
    static let shared: ServicoUseCases = {
        return ServicoUseCases()
    }()
    
    var dao: ServicoDAO?
    var observers: [Observer] = []
    
    private init() {}
    
    func set(dao: ServicoDAO) {
        self.dao = dao
    }
}


//MARK: UseCases Functions
extension ServicoUseCases {
    func cadastrar(object: Servico) {
        self.dao?.save(object: object)
        self.notify()
    }
    
    func atualizar(object: Servico, with id: Any) {
        
        self.dao?.update(object: object, id: id)
        self.notify()
    }
    
    func listar() -> [Servico] {
        self.dao?.get() ?? []
    }
    
    func remover(id: Any?) {
        if let id = id {
            self.dao?.delete(with: id)
            self.notify()
        }
    }
    
    func get(by id: Any?) -> Servico? {
        if let id = id {
            return self.dao?.get(by: id)
        }
        return nil
    }
}

extension ServicoUseCases: Subject {
    
    func remove(observer: Observer?) {
        if let observer = observer {
            self.observers.removeAll(where: { $0 as? UIViewController === observer as? UIViewController })
        }
    }
}

