//
//  DonoViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

//Padrão Controller
class DonoViewController: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    var id: Int?
    var useCases: DonoUseCases? //Padrão Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dono"
        
        self.useCases = DonoUseCases.shared
        self.setup()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apagar", style: .plain, target: self, action: #selector(DonoViewController.apagarAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(DonoViewController.cancelarAction))
    }
    
    func setup() {
        
        let dono = self.useCases?.get(by: self.id)
        
        self.nomeLabel.text = dono?.nome ?? ""
        self.cpfLabel.text = dono?.cpf ?? ""
        self.emailLabel.text = dono?.email ?? ""
        self.telefoneLabel.text = dono?.numeroTelefone ?? ""
        self.enderecoLabel.text = dono?.endereco ?? ""
    }
}

//MARK: Actions
extension DonoViewController {
    
    @objc func apagarAction() {
        
        self.useCases?.remover(id: self.id)
        self.dismiss(animated: true)
    }
    
    @objc func cancelarAction() {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func addAnimal(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AnimalFormsViewController") as? AnimalFormsViewController {
            controller.donoId = self.id
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
    
    @IBAction func visualizarAnimais(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ListarAnimaisViewController") as? ListarAnimaisViewController {
            controller.donoId = self.id
            
//            let navigation = UINavigationController(rootViewController: controller)
//            navigation.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
