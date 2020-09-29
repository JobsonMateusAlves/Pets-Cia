//
//  ServicoFormsViewController.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 28/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class ServicoFormsViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    var useCases: ServicoUseCases?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Servico"
        
        self.useCases = ServicoUseCases.shared
        self.setup()
    }
    
    func setup() {
        
        let servico: Servico? = self.useCases?.get(by: self.id)
        
        self.nomeTextField.text = servico?.nome
        self.descricaoTextView.text = servico?.descricao
        
        if let valor = servico?.valor.value{
            
            self.valorTextField.text = String(valor)
        }
    }
}

//MARK: Actions
extension ServicoFormsViewController {
    
    @IBAction func salvarAction(_ sender: Any) {
        
        let servico = Servico(
            nome: self.nomeTextField.text,
            descricao: self.descricaoTextView.text,
            valor: Double(self.valorTextField.text ?? "0")
        )
        
        if let id = self.id {
            self.useCases?.atualizar(object: servico, with: id)
        } else {
            self.useCases?.cadastrar(object: servico)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
