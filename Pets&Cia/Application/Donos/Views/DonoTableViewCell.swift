//
//  DonoTableViewCell.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 27/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

class DonoTableViewCell: UITableViewCell, NibReusable{

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(dono: Dono) {
        self.nomeLabel.text = dono.nome ?? ""
        self.telefoneLabel.text = dono.numeroTelefone ?? ""
    }
}
