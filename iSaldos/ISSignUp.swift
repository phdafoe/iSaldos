//
//  ISSignUp.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Parse

class APISignUp : NSObject{
    
    var username : String?
    var password : String?
    var nombre : String?
    var apellido : String?
    var email : String?
    var movil : String?
    
    init(pUsername : String, pPassword : String, pNombre : String, pApellido : String, pEmail : String, pMovil : String) {
        
        self.username = pUsername
        self.password = pPassword
        self.nombre = pNombre
        self.apellido = pApellido
        self.email = pEmail
        self.movil = pMovil
    }
    
    func signUpUser() throws -> Bool{
        guard camposVacios() else {
            throw CustomError.campoVacio
        }
        guard emailValido() else {
            throw CustomError.emailInvalido
        }
        
        guard ingresoUsuarioExitoso() else {
            throw CustomError.usuarioExistente
        }
        return true
    }
    
    func camposVacios() -> Bool{
        if !(username?.isEmpty)! && !(password?.isEmpty)! && !(nombre?.isEmpty)! && !(apellido?.isEmpty)! && !(email?.isEmpty)! && !(movil?.isEmpty)!{
            return true
        }else{
            return false
        }
    }
    
    func emailValido() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = email?.range(of: emailRegEx, options: .regularExpression)
        let result = emailTest != nil ? true : false
        return result
    }
    
    func ingresoUsuarioExitoso() -> Bool{
        var exitoso = false
        let usuario = PFUser()
        
        usuario.username = self.username
        usuario.password = self.password
        usuario.email = self.email
        usuario["nombre"] = self.nombre
        usuario["apellido"] = self.apellido
        usuario["movil"] = self.movil
        do {
            try usuario.signUp()
        }catch{
            print(CustomError.self)
        }
        
        exitoso = usuario.isNew
        return exitoso
        
    }
    
    
}


