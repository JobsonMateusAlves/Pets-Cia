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
    
    var id = RealmOptional<Int>()
    @objc dynamic var nome: String?
    @objc dynamic var cpf: String?
    @objc dynamic var email: String?
    @objc dynamic var numeroTelefone: String?
    @objc dynamic var endereço: String?
    
    init(nome: String, cpf: String, email: String, numeroTelefone: String, endereço: String) {
        super.init()
        
        self.nome = nome
        self.cpf = cpf
        self.email = email
        self.numeroTelefone = numeroTelefone
        self.endereço = endereço
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
