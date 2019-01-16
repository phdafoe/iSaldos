//
//  UserModel.swift
//  iSaldos
//
//  Created by Andres on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class UserModel: NSObject {
    
    var nombre : String?
    var apellido : String?
    var username : String?
    var imageProfile : PFFileObject? = nil
    
    init(pNombre : String, pApellido : String, pUsername : String, pImageProfile : PFFileObject) {
        self.nombre = pNombre
        self.apellido = pApellido
        self.username = pUsername
        self.imageProfile = pImageProfile
        super.init()
    }

}
