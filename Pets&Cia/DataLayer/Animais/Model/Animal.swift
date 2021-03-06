//
//  Animal.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift


class Animal: Object {
    
    public private(set) var id = RealmOptional<Int>()       // Realm? = Int?
    public private(set) var donoId = RealmOptional<Int>()  // private(set) - variavel so                                                 // pode ser alterada dentro da classe
    @objc dynamic public private(set) var nome: String?
    @objc dynamic public private(set) var raca: String?
    public private(set) var historicoServicos = List<String>()
    
    init(nome: String, raca: String, donoId: Int) {         //Declaração de variáveis
        super.init()                                        //? -> pode ter uma string ou nulo
                                                            
        self.donoId.value = donoId
        self.nome = nome
        self.raca = raca
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func set(nome: String) {
        self.nome = nome
    }
    
    func set(raca: String) {
        self.raca = raca
    }
    
    func set(historico: String) {
        self.historicoServicos.append(historico)
    }
}

