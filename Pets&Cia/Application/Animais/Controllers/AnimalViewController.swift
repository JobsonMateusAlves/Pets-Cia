//
//  AnimalViewController.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var racaLabel: UILabel!
    @IBOutlet weak var servicoTextField: UITextField!
    let picker = UIPickerView()
    
    var id: Int?
    var animal: Animal? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var servicos: [Servico] = []
    var selected: String? {
        didSet {
            self.servicoTextField.text = self.selected
        }
    }
    
    var animalUseCases: AnimalUseCases? //Padrão Controller
    var servicoUseCases: ServicoUseCases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Animal"
        
        self.animalUseCases = AnimalUseCases.shared
        self.servicoUseCases = ServicoUseCases.shared
        self.animalUseCases?.add(observer: self)
        self.setup()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apagar", style: .plain, target: self, action: #selector(AnimalViewController.apagarAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(AnimalViewController.cancelarAction))
        self.servicoTextField.addTarget(self, action: #selector(AnimalViewController.didClickedOnTextField), for: .touchDown)
        
        self.hidesKeyboardWhenTappedAround()
        
        self.setupPickerView()
    }
    
    func setup() {
        
        self.animal = self.animalUseCases?.get(by: self.id)
        
        self.nomeLabel.text = animal?.nome ?? ""
        self.racaLabel.text = animal?.raca ?? ""
        
        self.servicos = self.servicoUseCases?.listar() ?? []
    }
}

extension AnimalViewController: Observer {
    func update() {
        self.animal = self.animalUseCases?.get(by: self.id)
        self.selected = ""
    }
}

//MARK: Actions
extension AnimalViewController {
    
    @objc func apagarAction() {
        
        self.animalUseCases?.remover(id: self.id)
        self.dismiss(animated: true)
    }
    
    @objc func cancelarAction() {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func addServico(_ sender: Any) {
        
        if let selected = self.selected, !selected.isEmpty {
            self.animalUseCases?.add(servico: selected, id: self.id)
            self.dismissKeyboard()
        }
    }
}

extension AnimalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPickerView() {
        self.servicoTextField.inputView = self.picker
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.servicos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.servicos[row].nome
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selected = self.servicos[row].nome
    }
    
    @objc func didClickedOnTextField() {
        if let selected = self.selected {
            self.selected = selected.isEmpty ? (self.servicos.first?.nome ?? "") : self.selected
        } else {
            self.selected = self.servicos.first?.nome ?? ""
        }
        
    }
}

extension AnimalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animal?.historicoServicos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.text = self.animal?.historicoServicos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
