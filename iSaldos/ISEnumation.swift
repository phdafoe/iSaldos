//
//  ISEnumation.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation


/**
 Conectamos a la base de datos para hacer login y descargarnos los datos principales
 del usuario y los guardamos en **prefs(NSUserDefault)**.
 Devolvemos un String con el resultado de la consulta.
 - Parameter username: Nombre de usuario o Email del usuario que va a hacer login.
 - Parameter password: Password del usuario que va a hacer login sin encriptar.
 - Parameter completion: El resultado que nos devuelve.
 - Author: Andres Ocampo
 */
enum CustomError: Error {
    case campoVacio
    case emailInvalido
    case usuarioExistente
    case ingresoUsuarioError
}

extension CustomError: CustomStringConvertible{
    var description: String{
        switch self {
        case .campoVacio:
            return "Ingresa todos los campos"
        case .emailInvalido:
            return "Correo invalido"
        case .usuarioExistente:
            return "Ya esxiste este usuario"
        case .ingresoUsuarioError:
            return "Datos incorrectos"
        }
    }
}
