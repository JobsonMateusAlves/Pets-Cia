//
//  DependenciesInjector.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class DependenciesInjector {
    
    static func setup() {
        
        let realm = try! Realm()
        
        let dono = DonoDAO(realm: realm)
        let servico = ServicoDAO(realm: realm)
        let animal = AnimalDAO(realm: realm)
        
        DonoUseCases.shared.set(dao: dono)
        ServicoUseCases.shared.set(dao: servico)
        AnimalUseCases.shared.set(dao: animal)
    }
}
