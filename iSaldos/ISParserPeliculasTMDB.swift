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
                    case 401:
                        print("Error: \(error.localizedDescription)")
                        break
                    case 404:
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




