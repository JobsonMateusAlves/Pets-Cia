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
    
    var useCase: DonoUseCases?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dono"
        
        self.useCase = DonoUseCases.shared
        self.setup()
    }
    
    func setup() {
        
        let dono: Dono? = self.useCase?.get(by: self.id)
        
        self.nomeTextField.text = dono?.nome
        self.cpfTextField.text = dono?.cpf
        self.emailTextField.text = dono?.email
        self.telefoneTextField.text = dono?.numeroTelefone
        self.enderecoTextField.text = dono?.endereco
    }
    
    @IBAction func confirmarActioln(_ sender: Any) {
        
        let dono = Dono(
            nome: self.nomeTextField.text,
            cpf: self.cpfTextField.text,
            email: self.emailTextField.text,
            numeroTelefone: self.telefoneTextField.text,
            endereco: self.enderecoTextField.text
        )
        
        if let id = self.id {
            self.useCase?.atualizar(dono: dono, with: id)
        } else {
            self.useCase?.cadastrar(dono: dono)
        }
        
        self.dismiss(animated: true)
    }
    @IBAction func cancelar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
