//
//  DonoViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class DonoViewController: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    var id: Int?
    var useCases: DonoUseCases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dono"
        
        self.setup()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(DonoViewController.cancelarAction))
    }
    
    func setup() {
        self.useCases = DonoUseCases.shared
        let dono = self.useCases?.get(by: self.id)
        
        self.nomeLabel.text = dono?.nome ?? ""
        self.cpfLabel.text = dono?.cpf ?? ""
        self.emailLabel.text = dono?.email ?? ""
        self.telefoneLabel.text = dono?.numeroTelefone ?? ""
        self.enderecoLabel.text = dono?.endereco ?? ""
    }
    
    @IBAction func apagarAction(_ sender: Any) {
        
        self.useCases?.remover(id: self.id)
        self.dismiss(animated: true)
    }
    
    @objc func cancelarAction() {
        self.dismiss(animated: true)
    }
}
