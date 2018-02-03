//
//  ISMovieModel.swift
//  iSaldos
//
//  Created by Andres on 3/2/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISGenericModel {
    var artistName : String?
    var artworkUrl100 : String?
    var genres : [Genres]?
    var id : String?
    var kind : String?
    var name : String?
    var releaseDate : String?
    var url : String?
    
    init(json : JSON) {
        artistName = dimeString(json, nombre: "artistName")
        artworkUrl100 = dimeString(json, nombre: "artworkUrl100").replacingOccurrences(of: "200x200", with: "600x600")
        genres = [Genres.init(json: json["genres"])]
        id = dimeString(json, nombre: "id")
        kind = dimeString(json, nombre: "kind")
        name = dimeString(json, nombre: "name")
        releaseDate = dimeString(json, nombre: "releaseDate")
        url = dimeString(json, nombre: "url")
    }
}

struct Genres {
    var genreId : String?
    var name : String?
    var url : String?
    
    init(json: JSON) {
        genreId = dimeString(json, nombre: "genreId")
        name = dimeString(json, nombre: "name")
        url = dimeString(json, nombre: "url")
    }
}
