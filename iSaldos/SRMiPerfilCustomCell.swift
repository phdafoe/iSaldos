//
//  SRMiPerfilCustomCell.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//


import UIKit

class SRMiPerfilCustomCell: UITableViewCell {
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var myFotoFondoPerfil: UIImageView!
    @IBOutlet weak var myFotoPerfilUsuario: UIImageView!
    @IBOutlet weak var myNombrePerfilUsuario: UILabel!
    @IBOutlet weak var myFondoDegradadoFotoPerfil: UIImageView!
    @IBOutlet weak var myUsernameSportReviewLBL: UILabel!
    @IBOutlet weak var myNumeroPublicacionesLBL: UILabel!
    @IBOutlet weak var myNumeroSeguidoresLBL: UILabel!
    @IBOutlet weak var mySeguidoresLBL: UILabel!
    @IBOutlet weak var myBotonPublicaciones: UIButton!
    @IBOutlet weak var myBotonSeguidores: UIButton!
    @IBOutlet weak var myBotonSeguidos: UIButton!
    @IBOutlet weak var myBotonAjustesPerfilUsuario: UIButton!
    
    @IBOutlet weak var degradadoFondo: UIImageView!
    @IBOutlet weak var degradadoFoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myFotoPerfilUsuario.layer.cornerRadius = myFotoPerfilUsuario.frame.width / 8
        myFotoPerfilUsuario.layer.borderColor = UIColor(red: 252.0/255.0, green: 164.0/255.0, blue: 56.0/255.0, alpha: 1).cgColor
        myFotoPerfilUsuario.layer.borderWidth = 1.5
        
        myFondoDegradadoFotoPerfil.layer.cornerRadius = myFondoDegradadoFotoPerfil.frame.width / 8
        myFondoDegradadoFotoPerfil.clipsToBounds = true
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
