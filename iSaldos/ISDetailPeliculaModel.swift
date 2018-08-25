//
//  ISDetailPeliculaModel.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 25/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISDetailPeliculaModel {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    init(json : JSON) {
        adult = dimeBool(json, nombre: "adult")
        backdropPath = dimeString(json, nombre: "backdrop_path")
        belongsToCollection = BelongsToCollection.init(json: json)
        budget = dimeInt(json, nombre: "budget")
        genres = [Genre.init(json: json)]
        homepage = dimeString(json, nombre: "homepage")
        id = dimeInt(json, nombre: "id")
        imdbID = dimeString(json, nombre: "imdb_id")
        originalLanguage = dimeString(json, nombre: "original_language")
        originalTitle = dimeString(json, nombre: "original_title")
        overview = dimeString(json, nombre: "overview")
        popularity = dimeDouble(json, nombre: "popularity")
        posterPath = dimeString(json, nombre: "poster_path")
        productionCompanies = [ProductionCompany.init(json: json)]
        releaseDate = dimeString(json, nombre: "release_date")
        revenue = dimeInt(json, nombre: "revenue")
        runtime = dimeInt(json, nombre: "runtime")
        status = dimeString(json, nombre: "status")
        tagline = dimeString(json, nombre: "tagline")
        title = dimeString(json, nombre: "title")
        video = dimeBool(json, nombre: "video")
        voteAverage = dimeDouble(json, nombre: "vote_average")
        voteCount = dimeInt(json, nombre: "vote_count")
    }
}

struct BelongsToCollection {
    let id: Int
    let name, posterPath, backdropPath: String
    
    init(json : JSON) {
        id = dimeInt(json, nombre: "id")
        name = dimeString(json, nombre: "name")
        posterPath = dimeString(json, nombre: "poster_path")
        backdropPath = dimeString(json, nombre: "backdrop_path")
    }
}

struct Genre {
    let id: Int
    let name: String
    
    init(json : JSON) {
        id = dimeInt(json, nombre: "id")
        name = dimeString(json, nombre: "name")
    }
}

struct ProductionCompany {
    let id: Int
    let logoPath, name, originCountry: String
    
//    if let valorData = responseJSON.result.value{
//        let json = JSON(valorData)
//        var arrayMovies = [PeliculasModel]()
//        for c_movie in json["results"].arrayValue{
//            let modelData = PeliculasModel(json: c_movie)
//            arrayMovies.append(modelData)
//        }
//        completion(arrayMovies)
//    }
    
    
    init(json : JSON) {
        id = dimeInt(json, nombre: "id")
        logoPath = dimeString(json, nombre: "logo_path")
        name = dimeString(json, nombre: "name")
        originCountry = dimeString(json, nombre: "origin_country")
    }
}



