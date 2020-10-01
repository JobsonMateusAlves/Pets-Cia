//
//  AnimalFormsViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

//Padrão Controller
class AnimalFormsViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var racaTextField: UITextField!
    
    weak var useCases: AnimalUseCases?
    var id: Int?
    var donoId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Animal"
        
        self.useCases = AnimalUseCases.shared
        self.setup()
    }
    
    func setup() {
        
        let animal: Animal? = self.useCases?.get(by: self.id)
        
        self.nomeTextField.text = animal?.nome
        self.racaTextField.text = animal?.raca
    }
}

//MARK: Actions
extension AnimalFormsViewController {
    
    @IBAction func confirmarActioln(_ sender: Any) {
        
        guard !self.nomeTextField.text!.isEmpty, !self.racaTextField.text!.isEmpty else {
            self.showAlert()
            return
        }
        
        let animal = Animal(
            nome: self.nomeTextField.text!,
            raca: self.racaTextField.text!,
            donoId: self.donoId ?? 0
        )
        
        if let id = self.id {
            self.useCases?.atualizar(object: animal, with: id)
        } else {
            self.useCases?.cadastrar(object: animal)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    func showAlert() {
        let alerta = UIAlertController(title: "Atenção", message: "É necessário preencher todos os campos", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alerta, animated: true)
    }
}
