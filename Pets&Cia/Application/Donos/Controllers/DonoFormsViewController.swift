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
        
        self.disableTextFields()
        
        self.nomeTextField.text = dono?.nome
        self.cpfTextField.text = dono?.cpf
        self.emailTextField.text = dono?.email
        self.telefoneTextField.text = dono?.numeroTelefone
        self.enderecoTextField.text = dono?.endereco
    }
    
    func disableTextFields() {
        
        if self.id != nil {
            let componentColor = CGFloat(240/255)
            self.cpfTextField.backgroundColor = UIColor(red: componentColor, green: componentColor, blue: componentColor, alpha: 0.1)
        }
        
        self.cpfTextField.isUserInteractionEnabled = self.id == nil
    }
}

//MARK: Actions
extension DonoFormsViewController {
    
    @IBAction func confirmarActioln(_ sender: Any) {
        
        guard !self.nomeTextField.text!.isEmpty,
            !self.cpfTextField.text!.isEmpty,
            !self.telefoneTextField.text!.isEmpty,
            !self.enderecoTextField.text!.isEmpty,
            !self.emailTextField.text!.isEmpty else {
                
                self.showAlert()
                
                return
        }
        
        let dono = Dono(
            nome: self.nomeTextField.text!,
            cpf: self.cpfTextField.text!,
            email: self.emailTextField.text!,
            numeroTelefone: self.telefoneTextField.text!,
            endereco: self.enderecoTextField.text!
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
    
    func showAlert() {
        let alerta = UIAlertController(title: "Atenção", message: "É necessário preencher todos os campos", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alerta, animated: true)
    }//TODO: Criar classes para alertas.
}
