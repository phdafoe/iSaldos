//
//  UserPotImage.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class UserPotImage: UserModel {
    
    var imagePost : PFFile?
    var fechaCreacion : Date?
    var descripcion : String?
    
    init(pNombre: String, pApellido: String, pUsername: String, pImageProfile: PFFile, pImagePost : PFFile, pFechaCreacion : Date, pDescripcion : String) {
        
        self.imagePost = pImagePost
        self.fechaCreacion = pFechaCreacion
        self.descripcion = pDescripcion
        
        super.init(pNombre: pNombre,
                   pApellido: pApellido,
                   pUsername: pUsername,
                   pImageProfile: pImageProfile)
    }

}
