//
//  ISCastMovieModel.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 25/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISCastPeliculaModel{
    
    let castID: Int
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String
    
    init(json : JSON) {
        castID = dimeInt(json, nombre: "cast_id")
        character = dimeString(json, nombre: "character")
        creditID = dimeString(json, nombre: "credit_id")
        gender = dimeInt(json, nombre: "gender")
        id = dimeInt(json, nombre: "id")
        name = dimeString(json, nombre: "name")
        order = dimeInt(json, nombre: "order")
        profilePath = dimeString(json, nombre: "profile_path")
    }
    
}
