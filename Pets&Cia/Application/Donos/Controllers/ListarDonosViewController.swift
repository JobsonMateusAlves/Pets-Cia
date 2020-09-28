//
//  ListarDonosViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class ListarDonosViewController: UIViewController {
    
    var donos: [Dono] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var useCases: DonoUseCases?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.useCases = DonoUseCases.shared
        self.useCases?.add(observer: self)
        
        self.setupTableView()
        
        self.donos = self.useCases?.listar() ?? []
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: DonoTableViewCell.self)
    }
}

extension ListarDonosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.donos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as DonoTableViewCell
        
        cell.bind(dono: self.donos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showAlert(dono: self.donos[indexPath.row])
    }
}

extension ListarDonosViewController: Observer {
    func update() {
        self.donos = self.useCases?.listar() ?? []
    }
}

//MARK: Alert
extension ListarDonosViewController {
    
    func showAlert(dono: Dono) {
        
        let alert = UIAlertController(title: nil, message: "Escolha uma opção", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Informações", style: .default, handler: { (_) in
            self.openDetalhe(dono: dono)
        }))
        
        alert.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (_) in
            self.openEditar(dono: dono)
        }))
        
        self.present(alert, animated: true)
    }
    
    func openDetalhe(dono: Dono) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "DonoViewController") as? DonoViewController {
            controller.id = dono.id.value
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
    
    func openEditar(dono: Dono) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "DonoFormsViewController") as? DonoFormsViewController {
            controller.id = dono.id.value
            
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        }
    }
}
