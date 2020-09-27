//
//  Servico.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation

class Servico{
    
    private var nome: String
    private var descricao: String
    private var valor: Float
    
    init(nome: String, descricao: String, valor: Float){
        self.nome = nome
        self.descricao = descricao
        self.valor = valor
    }
    
    func getNome() -> String{
        return nome
    }
    
    func getDescricao() -> String{
        return descricao
    }
    
    func getValor() -> Float{
        return valor
    }
    
    func setNome(nome: String){
        self.nome = nome
    }
    
    func setDescricao(descricao: String){
        self.descricao = descricao
    }
    
    func setValor(valor: Float){
        self.valor = valor
    }
    
}
