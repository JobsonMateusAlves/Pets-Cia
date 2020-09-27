//
//  DonoDAO.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

class DonoDAO: DAO {
    typealias T = Dono
    
    var realm: Realm
    
    //MARK: Inits
    public init(realm: Realm) {
        self.realm = realm
    }
    
    func setAutoIncrement(of object: Dono, with id: Any) {
        object.id.value = id as? Int
    }
}
