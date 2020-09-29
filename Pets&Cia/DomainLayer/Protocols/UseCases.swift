//
//  UseCases.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation

protocol UseCases {
    associatedtype T

    func cadastrar(object: T)
    func atualizar(object: T, with id: Any)
    func listar() -> [T]
    func remover(id: Any?)
    func get(by id: Any?) -> T?
}
