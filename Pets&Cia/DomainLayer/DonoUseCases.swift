//
//  DonoUseCases.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

//Padrão Singleton
//Padrão Observer
class DonoUseCases: UseCases {

    typealias T = Dono
    
    static let shared: DonoUseCases = {
        return DonoUseCases()
    }()
    
    var dao: DonoDAO?
    var observers: [Observer] = []
    
    private init() {}
    
    func set(dao: DonoDAO) {
        self.dao = dao
    }
}

//MARK: UseCases Functions
extension DonoUseCases {
    func cadastrar(dono: Dono) {
        self.dao?.save(object: dono)
        self.notify()
    }
    
    func atualizar(dono: Dono, with id: Any) {
        
        self.dao?.update(object: dono, id: id)
        self.notify()
    }
    
    func listar() -> [Dono] {
        self.dao?.get() ?? []
    }
    
    func remover(id: Any?) {
        if let id = id {
            self.dao?.delete(with: id)
            self.notify()
        }
    }
    
    func get(by id: Any?) -> Dono? {
        if let id = id {
            return self.dao?.get(by: id)
        }
        return nil
    }
}

extension DonoUseCases: Subject {
    
    func remove(observer: Observer?) {
        if let observer = observer {
            self.observers.removeAll(where: { $0 as? UIViewController === observer as? UIViewController })
        }
    }
}



