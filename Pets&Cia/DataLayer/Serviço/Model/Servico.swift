//
//  Servico.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class Servico: Object {

    public private(set) var id = RealmOptional<Int>()
    @objc dynamic public private(set) var nome: String?
    @objc dynamic public private(set) var descricao: String?
    public private(set) var valor = RealmOptional<Double>()

    init(nome: String?, descricao: String?, valor: Double?){
        self.nome = nome
        self.descricao = descricao
        self.valor.value = valor
    }

    required init() {
        super.init()
    }

    func set(nome: String?) {
        self.nome = nome
    }

    func set(descricao: String?) {
        self.descricao = descricao
    }

    func set(valor: Double?) {
        self.valor.value = valor
    }
}
