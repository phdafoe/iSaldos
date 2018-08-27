//
//  ISDetailPeople.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 27/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISDetailPeopleModel {
    
    let popularity: Double
    let id: Int
    let profilePath, name: String
    let knownFor: [KnownFor]
    
    init(json : JSON) {
        popularity = dimeDouble(json, nombre: "popularity")
        id = dimeInt(json, nombre: "id")
        profilePath = dimeString(json, nombre: "profile_path")
        name = dimeString(json, nombre: "name")
        knownFor = [KnownFor.init(json: json)]
    }
    
}

struct KnownFor {
    
    let voteAverage: Double
    let mediaType, title: String
    let popularity: Double
    let posterPath: String
    let backdropPath: String
    let overview, releaseDate: String
    
    init(json : JSON) {
        voteAverage = dimeDouble(json, nombre: "voteAverage")
        mediaType = dimeString(json, nombre: "media_type")
        title = dimeString(json, nombre: "title")
        popularity = dimeDouble(json, nombre: "popularity")
        posterPath = dimeString(json, nombre: "poster_path")
        backdropPath = dimeString(json, nombre: "backdrop_path")
        overview = dimeString(json, nombre: "overview")
        releaseDate = dimeString(json, nombre: "release_date")
    }
    
    
}
