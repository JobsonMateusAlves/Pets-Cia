//
//  ServicoTableViewCell.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

class ServicoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(servico: Servico) {
        self.nomeLabel.text = servico.nome
        self.valorLabel.text = String(servico.valor.value ?? 0)
        self.descricaoLabel.text = servico.descricao
    }
}
