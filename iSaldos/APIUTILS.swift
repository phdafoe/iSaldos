//
//  APIUTILS.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let USER_DEFAULT = CustomUserDefaults()
}

struct Colores {
    let GRIS_NAV_TAB = #colorLiteral(red: 0.2765139249, green: 0.2765139249, blue: 0.2765139249, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct LLamadas {
    let BASE_API_URL_PORTADAS = "https://pre.sportreview.es/api/"
    
    let OFERTAS = "oferta"
    let CUPONES = "cupon"
    let CONCURSO = "concurso"
    
    let BASE_PHOTO_URL = "http://app.clubsinergias.es/uploads/promociones/"
    
    let PROMOCIONES_SERVICE = "promociones"
    
    let BASEURLIDPARSE = "http://app.clubsinergias.es/api_comercios.php?idparse="
    let BASE_URL = "http://app.clubsinergias.es/api_comercios.php?"
    let BASEURLIDCLIENTE = "http://app.clubsinergias.es/api_comercios.php?idcliente="
    let BASEIDLOCALIDAD = "idlocalidad="
    let BASEIDP = "&p="
    let BASEIDTIPO = "&tipo="
}

struct CustomUserDefaults {
    let VISTA_GALERIA_INICIAL = "vistaGaleriaInicial"
    let VISTA_LOGIN = "vistaLogin"
    let VISTA_REGISTRO = "vistaRegistro"
}
