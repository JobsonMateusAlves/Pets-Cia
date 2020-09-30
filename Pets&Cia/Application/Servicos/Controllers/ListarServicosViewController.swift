//
//  ListarServicosViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class ListarServicosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var servicos: [Servico] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var useCases: ServicoUseCases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.useCases = ServicoUseCases.shared
        self.useCases?.add(observer: self)
        
        self.setupTableView()
        
        self.servicos = self.useCases?.listar() ?? []
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.useCases?.remove(observer: self)
        }
    }
}

extension ListarServicosViewController: Observer {
    func update() {
        self.servicos = self.useCases?.listar() ?? []
    }
}

//MARK: TableView
extension ListarServicosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: ServicoTableViewCell.self)
        self.tableView.rowHeight = 1000
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servicos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as ServicoTableViewCell
        
        cell.bind(servico: self.servicos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showAlert(servico: self.servicos[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

//MARK: Alert
extension ListarServicosViewController {
    
    func showAlert(servico: Servico) {
        
        let alert = UIAlertController(title: nil, message: "Escolha uma opção", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Apagar", style: .default, handler: { (_) in
            self.apagar(servico: servico)
        }))
        
        alert.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (_) in
            self.openEditar(servico: servico)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func apagar(servico: Servico) {
        
        self.useCases?.remover(id: servico.id.value)
    }
    
    func openEditar(servico: Servico) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ServicoFormsViewController") as? ServicoFormsViewController {
            controller.id = servico.id.value
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
}

