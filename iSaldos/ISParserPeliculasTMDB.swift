//
//  ISParserPeliculasTMDB.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 17/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ISParserPeliculas : NSObject {
    
    static let shared = ISParserPeliculas()
    
    func getDataServicePeliculas(_ apiKey : String, numberPage : Int, completion: @escaping ([PeliculasModel]?) -> ()){
        
        let format = CONSTANTES.LLAMADAS.BASE_URL_TMDB
        let arguments : [CVarArg] = [apiKey, numberPage]
        let urlsString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlsString)!)
        
        delegate?.sessionManager.request(urlRequest).validate().responseJSON{ (responseJSON) in
            switch responseJSON.result {
            case .success:
                if let valorData = responseJSON.result.value{
                    let json = JSON(valorData)
                    var arrayMovies = [PeliculasModel]()
                    for c_movie in json["results"].arrayValue{
                        let modelData = PeliculasModel(json: c_movie)
                        arrayMovies.append(modelData)
                    }
                    completion(arrayMovies)
                }
            case .failure(let error):
                if let httpStatusCode = responseJSON.response?.statusCode{
                    switch(httpStatusCode){
                    case 400:
                        print("Error: \(error.localizedDescription)")
                        break
                    default:
                        print("Error: \(error.localizedDescription)")
                        break
                    }
                }else{
                    print("Error: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
    }
    
    func getDataServiceDetailPeliculas(_ id : String, apiKey : String, completion : @escaping (ISDetailPeliculaModel?, [ProductionCompany]?) -> ()){
        
        
        let format = CONSTANTES.LLAMADAS.BASE_URL_DETAIL_MOVIE
        let arguments : [CVarArg] = [id, apiKey]
        let urlsString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlsString)!)
        
        delegate?.sessionManager.request(urlRequest).validate().responseJSON{ (responseJSON) in
            switch responseJSON.result {
            case .success:
                if let valorData = responseJSON.result.value{
                    let json = JSON(valorData)
                    let detailMovies = ISDetailPeliculaModel(json: json)
                    var arrayCompany = [ProductionCompany]()
                    for c_company in json["production_companies"].arrayValue{
                        let modelData = ProductionCompany(json: c_company)
                        arrayCompany.append(modelData)
                    }
                    completion(detailMovies, arrayCompany)
                }
            case .failure(let error):
                if let httpStatusCode = responseJSON.response?.statusCode{
                    switch(httpStatusCode){
                    case 400:
                        print("Error: \(error.localizedDescription)")
                        break
                    default:
                        print("Error: \(error.localizedDescription)")
                        break
                    }
                }else{
                    print("Error: \(error.localizedDescription)")
                }
                completion(nil, [])
            }
        }
    }
    
    func getDataServiceCast(_ id : String, apiKey : String, completion: @escaping ([ISCastPeliculaModel]?) -> ()){
        
        let format = CONSTANTES.LLAMADAS.BASE_ULR_CAST_MOVIE
        let arguments : [CVarArg] = [id, apiKey]
        let urlsString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlsString)!)
        
        delegate?.sessionManager.request(urlRequest).validate().responseJSON{ (responseJSON) in
            switch responseJSON.result {
            case .success:
                if let valorData = responseJSON.result.value{
                    let json = JSON(valorData)
                    var arrayCast = [ISCastPeliculaModel]()
                    for c_cast in json["cast"].arrayValue{
                        let modelData = ISCastPeliculaModel(json: c_cast)
                        arrayCast.append(modelData)
                    }
                    completion(arrayCast)
                }
            case .failure(let error):
                if let httpStatusCode = responseJSON.response?.statusCode{
                    switch(httpStatusCode){
                    case 400:
                        print("Error: \(error.localizedDescription)")
                        break
                    default:
                        print("Error: \(error.localizedDescription)")
                        break
                    }
                }else{
                    print("Error: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
    }
    
    
    func getDataServicePopularTV(_ apiKey : String, completion: @escaping ([ISPopularTVModel]?) -> ()){
        
        let format = CONSTANTES.LLAMADAS.BASE_URL_POPULAR_TV
        let arguments : [CVarArg] = [apiKey]
        let urlsString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlsString)!)
        
        delegate?.sessionManager.request(urlRequest).validate().responseJSON{ (responseJSON) in
            switch responseJSON.result {
            case .success:
                if let valorData = responseJSON.result.value{
                    let json = JSON(valorData)
                    var arrayMovies = [ISPopularTVModel]()
                    for c_movie in json["results"].arrayValue{
                        let modelData = ISPopularTVModel(json: c_movie)
                        arrayMovies.append(modelData)
                    }
                    completion(arrayMovies)
                }
            case .failure(let error):
                if let httpStatusCode = responseJSON.response?.statusCode{
                    switch(httpStatusCode){
                    case 400:
                        print("Error: \(error.localizedDescription)")
                        break
                    default:
                        print("Error: \(error.localizedDescription)")
                        break
                    }
                }else{
                    print("Error: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
    }
    
    
}




