//
//  ISPeliculasModel.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 17/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PeliculasModel {
    
    let vote_count : Int?
    let id : Int?
    let video : Bool?
    let vote_average : Double?
    let title : String?
    let popularity : Double?
    let poster_path : String?
    let original_language : String?
    let original_title : String?
    let backdrop_path : String?
    let adult : Bool?
    let overview : String?
    let release_date : String?
    
    init(json: JSON) {
        vote_count =  dimeInt(json, nombre: "vote_count")
        id = dimeInt(json, nombre: "id")
        video = dimeBool(json, nombre: "video")
        vote_average = dimeDouble(json, nombre: "vote_average")
        title = dimeString(json, nombre: "title")
        popularity = dimeDouble(json, nombre: "popularity")
        poster_path = dimeString(json, nombre: "poster_path")
        original_language = dimeString(json, nombre: "original_language")
        original_title = dimeString(json, nombre: "original_title")
        backdrop_path = dimeString(json, nombre: "backdrop_path")
        adult = dimeBool(json, nombre: "adult")
        overview = dimeString(json, nombre: "overview")
        release_date  = dimeString(json, nombre: "release_date")
    }
}





