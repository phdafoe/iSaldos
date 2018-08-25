//
//  ISPopularTVModel.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 26/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISPopularTVModel {
    let originalName: String
    let name: String
    let popularity: Double
    let voteCount: Int
    let firstAirDate, backdropPath: String
    let id: Int
    let voteAverage: Double
    let overview, posterPath: String
    
    init(json : JSON) {
        originalName = dimeString(json, nombre: "original_name")
        name = dimeString(json, nombre: "name")
        popularity = dimeDouble(json, nombre: "popularity")
        voteCount = dimeInt(json, nombre: "vote_count")
        firstAirDate = dimeString(json, nombre: "first_air_date")
        backdropPath = dimeString(json, nombre: "backdrop_path")
        id = dimeInt(json, nombre: "id")
        voteAverage = dimeDouble(json, nombre: "vote_average")
        overview = dimeString(json, nombre: "overview")
        posterPath = dimeString(json, nombre: "poster_path") 
    }
}


