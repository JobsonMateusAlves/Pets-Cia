//
//  UIViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 30/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hidesKeyboardWhenTappedAround() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
