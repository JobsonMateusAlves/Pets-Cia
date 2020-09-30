//
//  ListarAnimaisViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class ListarAnimaisViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var animais: [Animal] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var useCases: AnimalUseCases?
    var donoId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.useCases = AnimalUseCases.shared
        self.useCases?.add(observer: self)
        
        self.setupTableView()
        
        if let donoId = self.donoId {
            self.animais = self.useCases?.listar(by: donoId) ?? []
        } else {
            self.animais = self.useCases?.listar() ?? []
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.useCases?.remove(observer: self)
        }
    }
}

extension ListarAnimaisViewController: Observer {
    func update() {
        self.animais = self.useCases?.listar() ?? []
    }
}

//MARK: TableView
extension ListarAnimaisViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: AnimalTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as AnimalTableViewCell
        
        cell.bind(animal: self.animais[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showAlert(animal: self.animais[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Alert
extension ListarAnimaisViewController {
    
    func showAlert(animal: Animal) {
        
        let alert = UIAlertController(title: nil, message: "Escolha uma opção", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Informações", style: .default, handler: { (_) in
            self.openDetalhe(animal: animal)
        }))
        
        alert.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (_) in
            self.openEditar(animal: animal)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func openDetalhe(animal: Animal) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AnimalViewController") as? AnimalViewController {
            controller.id = animal.id.value
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
    
    func openEditar(animal: Animal) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AnimalFormsViewController") as? AnimalFormsViewController {
            controller.id = animal.id.value
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
}
