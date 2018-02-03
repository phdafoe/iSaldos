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
var diccionarioImagenes = [String: UIImage?]()

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let USER_DEFAULT = CustomUserDefaults()
    let PARSE_DATA = ParseData()
}

struct Colores {
    let GRIS_NAV_TAB = #colorLiteral(red: 0.2765139249, green: 0.2765139249, blue: 0.2765139249, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1725490196, alpha: 1)
}

struct LLamadas {
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
