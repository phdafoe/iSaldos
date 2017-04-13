//
//  ISEnumation.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation


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
