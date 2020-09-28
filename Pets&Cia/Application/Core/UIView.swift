//
//  UIView.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 26/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit

enum TypeConstraint {
    case lessThanOrEqualTo
    case greaterThanOrEqualTo
    case equalTo
}

//Padrões -> Builder
extension UIView {
    
    @discardableResult
    func allSidesOfSuperView(with value: CGFloat = 0) -> UIView {
        
        guard let superview = self.superview else {
            return self
        }
        
        return self.top(anchor: superview.topAnchor)
            .left(anchor: superview.leftAnchor)
            .right(anchor: superview.rightAnchor)
            .bottom(anchor: superview.bottomAnchor)
    }
    
    @discardableResult
    func top(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.topAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func bottom(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.bottomAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func left(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.leftAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func right(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.rightAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func centerX(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.centerXAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.centerXAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.centerXAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        }
        return self
    }
    
    @discardableResult
    func centerY(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        switch type {
        case .equalTo:
            self.centerYAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.centerYAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.centerYAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        }
        return self
    }
    
    //MARK: Width
    @discardableResult
    func width(anchor: NSLayoutDimension? = nil, multiplier: CGFloat = 1, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        guard let anchor = anchor else {
            self.width(value: value, type: type)
            return self
        }
        
        self.width(anchor: anchor, multiplier: multiplier, value: value, type: type)
        
        return self
    }

    private func width(value: CGFloat, type: TypeConstraint) {
        
        switch type {
        case .equalTo:
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .lessThanOrEqualTo:
            self.widthAnchor.constraint(lessThanOrEqualToConstant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: value).isActive = true
        }
    }
    
    private func width(anchor: NSLayoutDimension, multiplier: CGFloat, value: CGFloat, type: TypeConstraint) {
        
        switch type {
        case .equalTo:
            self.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.widthAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: value).isActive = true
        }
    }
    //MARK: Height
    @discardableResult
    func height(anchor: NSLayoutDimension? = nil, multiplier: CGFloat = 1, type: TypeConstraint = .equalTo, value: CGFloat = 0) -> UIView {
        
        guard let anchor = anchor else {
            self.height(value: value, type: type)
            return self
        }
        
        self.height(anchor: anchor, multiplier: multiplier, type: type, value: value)
        
        return self
    }

    private func height(value: CGFloat, type: TypeConstraint) {
        
        switch type {
        case .equalTo:
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
        case .lessThanOrEqualTo:
            self.heightAnchor.constraint(lessThanOrEqualToConstant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: value).isActive = true
        }
    }
    
    private func height(anchor: NSLayoutDimension, multiplier: CGFloat, type: TypeConstraint, value: CGFloat) {
        
        switch type {
        case .equalTo:
            self.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: value).isActive = true
        case .lessThanOrEqualTo:
            self.heightAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: value).isActive = true
        case .greaterThanOrEqualTo:
            self.heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: value).isActive = true
        }
    }
}
