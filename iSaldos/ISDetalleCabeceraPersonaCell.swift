//
//  ISDetalleCabeceraPersonaCell.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 27/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class ISDetalleCabeceraPersonaCell: UITableViewCell {
    
    //IBOUTLETS
    @IBOutlet weak var myImageProfile: UIImageView!
    @IBOutlet weak var myNameProfile: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
