//
//  DonoUseCases.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class DonoUseCases: UseCases, Subject {
    
    typealias T = Dono
    
    static let shared: DonoUseCases = {
        return DonoUseCases()
    }()
    
    var dao: DonoDAO?
    var observer: Observer?
    
    private init() {}
    
    func set(dao: DonoDAO) {
        self.dao = dao
    }
    
    func add(observer: Observer?) {
        self.observer = observer
    }
}

//MARK: UseCases Functions
extension DonoUseCases {
    func cadastrar(dono: Dono) {
        self.dao?.save(object: dono)
        self.observer?.update()
    }
    
    func atualizar(dono: Dono, with id: Any) {
        
        self.dao?.update(object: dono, id: id)
        self.observer?.update()
    }
    
    func listar() -> [Dono] {
        self.dao?.get() ?? []
    }
    
    func remover(id: Any?) {
        if let id = id {
            self.dao?.delete(with: id)
            self.observer?.update()
        }
    }
    
    func get(by id: Any?) -> Dono? {
        if let id = id {
            return self.dao?.get(by: id)
        }
        return nil
    }
}

protocol Subject {
    var observer: Observer? { get }
    func add(observer: Observer?)
}
