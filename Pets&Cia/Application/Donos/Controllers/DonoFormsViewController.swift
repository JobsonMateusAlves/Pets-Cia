//
//  CadastroDonoViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class DonoFormsViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var enderecoTextField: UITextField!
    
    weak var useCases: DonoUseCases?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dono"
        
        self.useCases = DonoUseCases.shared
        self.setup()
    }
    
    func setup() {
        
        let dono: Dono? = self.useCases?.get(by: self.id)
        
        self.nomeTextField.text = dono?.nome
        self.cpfTextField.text = dono?.cpf
        self.emailTextField.text = dono?.email
        self.telefoneTextField.text = dono?.numeroTelefone
        self.enderecoTextField.text = dono?.endereco
    }
}

//MARK: Actions
extension DonoFormsViewController {
    
    @IBAction func confirmarActioln(_ sender: Any) {
        
        let dono = Dono(
            nome: self.nomeTextField.text,
            cpf: self.cpfTextField.text,
            email: self.emailTextField.text,
            numeroTelefone: self.telefoneTextField.text,
            endereco: self.enderecoTextField.text
        )
        
        if let id = self.id {
            self.useCases?.atualizar(object: dono, with: id)
        } else {
            self.useCases?.cadastrar(object: dono)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
