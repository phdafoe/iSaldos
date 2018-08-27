//
//  ISDetailTVShowsModel.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 26/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ISDetailTVShowsModel {
    
    let backdropPath: String
    let firstAirDate: String
    let homepage: String
    let id: Int
    let lastAirDate: String
    let name: String
    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [Network]
    let seasons: [Season]
    let voteAverage: Double
    let voteCount: Int
    
    init(json : JSON) {
        backdropPath = dimeString(json, nombre: "backdrop_path")
        firstAirDate = dimeString(json, nombre: "first_air_date")
        homepage = dimeString(json, nombre: "homepage")
        id = dimeInt(json, nombre: "id")
        lastAirDate = dimeString(json, nombre: "last_air_date")
        name = dimeString(json, nombre: "name")
        networks = [Network.init(json: json)]
        numberOfEpisodes = dimeInt(json, nombre: "number_of_episodes")
        numberOfSeasons = dimeInt(json, nombre: "number_of_seasons")
        popularity = dimeDouble(json, nombre: "popularity")
        posterPath = dimeString(json, nombre: "poster_path")
        productionCompanies = [Network.init(json: json)]
        seasons = [Season.init(json: json)]
        voteAverage = dimeDouble(json, nombre: "vote_average")
        voteCount = dimeInt(json, nombre: "vote_count")
        originalName = dimeString(json, nombre: "original_name")
        overview = dimeString(json, nombre: "overview")
    }
    
}

struct Network {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String
    
    init(json : JSON) {
        name = dimeString(json, nombre: "name")
        id = dimeInt(json, nombre: "id")
        logoPath = dimeString(json, nombre: "logo_path")
        originCountry = dimeString(json, nombre: "origin_country")
    }
}

struct Season {
    let airDate: String?
    let episodeCount, id: Int
    let name, overview: String
    let posterPath: String?
    let seasonNumber: Int
    
    init(json : JSON) {
        airDate = dimeString(json, nombre: "air_date")
        episodeCount = dimeInt(json, nombre: "episode_count")
        id = dimeInt(json, nombre: "id")
        name = dimeString(json, nombre: "name")
        overview = dimeString(json, nombre: "overview")
        posterPath = dimeString(json, nombre: "poster_path")
        seasonNumber = dimeInt(json, nombre: "season_number")
        
        
    }
}
