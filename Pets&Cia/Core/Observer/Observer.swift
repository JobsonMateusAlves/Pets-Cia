//
//  Observer.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit

//Observer
protocol Observer {
    func update()
}

protocol Subject {
    var observers: [Observer] { get set }
    mutating func add(observer: Observer)
    mutating func remove(observer: Observer?)
    func notify()
}

extension Subject {
    
    mutating func add(observer: Observer) {
        self.observers.append(observer)
    }
    
    func notify() {
        self.observers.forEach { (observer) in
            observer.update()
        }
    }
}
