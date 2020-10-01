//
//  ServicoFormsViewController.swift
//  Pets&Cia
//
//  Created by Pedro Jaime on 28/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit
import RealmSwift

//Padrão Controller
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
        self.setupLayout()
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
        
        guard !self.nomeTextField.text!.isEmpty, !self.valorTextField.text!.isEmpty else {
            
            self.showAlert()
            
            return
        }
        
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
    
    func showAlert() {
        let alerta = UIAlertController(title: "Atenção", message: "É necessário preencher todos os campos", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alerta, animated: true)
    }
}

extension ServicoFormsViewController {
    func setupLayout() {
        
        let componentColor = CGFloat(220/255)
        
        self.descricaoTextView.layer.borderWidth = 1
        self.descricaoTextView.layer.borderColor = UIColor(red: componentColor, green: componentColor, blue: componentColor, alpha: 0.2).cgColor
        
        self.descricaoTextView.layer.cornerRadius = 5
        self.descricaoTextView.clipsToBounds = true
    }
}
