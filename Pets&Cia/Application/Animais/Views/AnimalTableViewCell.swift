//
//  AnimalTableViewCell.swift
//  Pets&Cia
//
//  Created by Jobson Mateus on 29/09/20.
//  Copyright © 2020 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

class AnimalTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var racaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(animal: Animal) {
        self.nomeLabel.text = animal.nome
        self.racaLabel.text = animal.raca
    }
}
