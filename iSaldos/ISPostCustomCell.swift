//
//  ISPostCustomCell.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISPostCustomCell: UITableViewCell {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagePerfil: UIImageView!
    @IBOutlet weak var myUsernamePerfil: UILabel!
    @IBOutlet weak var myFechaPerfil: UILabel!
    @IBOutlet weak var myNombreApellidoPerfil: UILabel!
    @IBOutlet weak var myTextoDescripcionPerfil: UILabel!
    @IBOutlet weak var myImagenPostPerfil: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
