//
//  APIUTILS.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON

let CONSTANTES = Constantes()
var jsonDataGenerico : JSON?
var imagenSeleccionada : UIImage?
var diccionarioImagenes = [Int: UIImage?]()
let delegate = UIApplication.shared.delegate as? AppDelegate

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let USER_DEFAULT = CustomUserDefaults()
    let PARSE_DATA = ParseData()
    let API_KEY = APIKey()
}

struct Colores {
    let GRIS_NAV_TAB = #colorLiteral(red: 0.2765139249, green: 0.2765139249, blue: 0.2765139249, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1725490196, alpha: 1)
}

struct APIKey {
    let API_KEY = "e260c34cd5cff1c6f9d3f586c7230da4"
}

struct LLamadas {
    
    let BASE_URL_TMDB = "https://api.themoviedb.org/3/discover/movie?api_key=%@&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=%d"
    let BASE_URL_DETAIL_MOVIE = "https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US"
    let BASE_ULR_CAST_MOVIE = "http://api.themoviedb.org/3/movie/%@/casts?api_key=%@"
    let BASE_URL_IMAGE_TMDB = "https://image.tmdb.org/t/p/w500"
    
    let BASE_URL_POPULAR_TV = "https://api.themoviedb.org/3/tv/popular?api_key=%@&language=en-US&page=1"
    let BASE_URL_DETAIL_POPULAR_TV = "https://api.themoviedb.org/3/tv/%@?api_key=%@&language=en-US"
    
    let BASE_URL_DETAIL_PEOPLE = "https://api.themoviedb.org/3/search/person?api_key=%@&language=en-US&query=%@&page=1&include_adult=false"
    
    
    let BASE_URL_APPLE = "https://rss.itunes.apple.com/api/v1/us/%@/%@/all/%@/explicit.json"
    let MOVIES_APPLE = "movies"
    let BOOKS_APPLE = "books"
    let APPLE_MUSIC = "apple-music"
    let ITUNES_MUSIC = "itunes-music"
    
    let TOP_MOVIE_APPLE = "top-movies"
    let TOP_FREE_APPLE = "top-free"
    let HOT_TRACK_APPLE = "hot-tracks"
}

struct ParseData {
    let NOMBRE_TABLA_IMAGEN = "ImageProfile"
    let IMAGEN_URL = "imagenFile"
    let USERNAME_PARSE = "username"
}

struct CustomUserDefaults {
    
    let VISTA_GALERIA_INICIAL = "vistaGaleriaInicial"
    let VISTA_LOGIN = "vistaLogin"
    let VISTA_REGISTRO = "vistaRegistro"
    let ISLOGGED = "inicioSesion"
    
    let NOMBRE_USUARIO = "nombre"
    let APELLIDO_USUARIO = "apellido"
    
    
}



