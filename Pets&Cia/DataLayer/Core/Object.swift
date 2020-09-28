//
//  Objects.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

protocol DetachableObject: AnyObject {
    
    func detached() -> Self
}

extension Object {
    func detached() -> Self {
        
        let detached = type(of: self).init()
        
        for property in objectSchema.properties {
            
            guard let value = value(forKey: property.name) else {
                
                continue
            }
            
            if let detachable = value as? DetachableObject {
                
                detached.setValue(detachable.detached(), forKey: property.name)
                
            } else {
                
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}
