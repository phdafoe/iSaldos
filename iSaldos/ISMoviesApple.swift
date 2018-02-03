//
//  ISMoviesApple.swift
//  iSaldos
//
//  Created by Andres on 3/2/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
import Alamofire

class ISMoviesApple{
    
    func getDataServiceGeneric(_ movies : String, topMovies : String, numberMovies : String) -> Promise<JSON>{
        let arguments : [CVarArg] = [movies, topMovies, numberMovies]
        let urlString = String(format: CONSTANTES.LLAMADAS.BASE_URL_APPLE, arguments: arguments)
        let request = URLRequest(url: URL(string: urlString)!)
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            jsonDataGenerico = JSON(data)
            return jsonDataGenerico!
        }
    }
    
    func getParseGeneric(completion : @escaping (([ISGenericModel]) -> ())){
        var arrayGeneric = [ISGenericModel]()
        for c_movie in (jsonDataGenerico?["feed"]["results"].arrayValue)!{
            let movieModel = ISGenericModel(json: c_movie)
            arrayGeneric.append(movieModel)
            completion(arrayGeneric)
        }
    }
    
}
