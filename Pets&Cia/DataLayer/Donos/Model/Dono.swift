//
//  Dono.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift


class Dono: Object {
    
    public private(set) var id = RealmOptional<Int>()
    @objc dynamic public private(set) var nome: String?
    @objc dynamic public private(set) var cpf: String?
    @objc dynamic public private(set) var email: String?
    @objc dynamic public private(set) var numeroTelefone: String?
    @objc dynamic public private(set) var endereco: String?
    
    init(nome: String?, cpf: String?, email: String?, numeroTelefone: String?, endereco: String?) {
        super.init()
        
        self.nome = nome
        self.cpf = cpf
        self.email = email
        self.numeroTelefone = numeroTelefone
        self.endereco = endereco
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func set(nome: String?) {
        self.nome = nome
    }
    
    func set(cpf: String?) {
        self.cpf = cpf
    }
    
    func set(email: String?) {
        self.email = email
    }
    
    func set(numeroTelefone: String?) {
        self.numeroTelefone = numeroTelefone
    }
    
    func set(endereco: String?) {
        self.endereco = endereco
    }
}
