//
//  ISSignIn.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Parse

class APISignIn: NSObject {
    
    var username : String?
    var password : String?
    
    
    init(pUsername : String, pPassword : String) {
        self.username = pUsername
        self.password = pPassword
    }
    
    
    func signInUser() throws{
        guard camposVacios() else {
            throw CustomError.campoVacio
        }
        guard validarDatosUsuario() else {
            throw CustomError.ingresoUsuarioError
        }
    }
    
    func camposVacios() -> Bool{
        if !(username?.isEmpty)! && !(password?.isEmpty)!{
            return true
        }else{
            return false
        }
    }
    
    func validarDatosUsuario() -> Bool{
        
        do{
           try PFUser.logIn(withUsername: username!, password: password!)
        }catch let error{
            print("Error: \(error.localizedDescription)")
        }
        
        if PFUser.current() != nil{
            return true
        }else{
            return false
        }
    }
    

}
