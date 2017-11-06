//
//  ISParsesCupones.swift
//  iSaldos
//
//  Created by Andres on 6/11/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ISParsesCupones: NSObject {

    
    var jsonDataCupones : JSON?
    
    func getDatosCupones() -> Promise<JSON>{
        let request = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_URL_CUPONES)!)
        print(request)
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            self.jsonDataCupones = JSON(data)
            return self.jsonDataCupones!
        }
    }
    
    
    func getParserCupones() -> [ISOfertasModel]{
        var arrayCuponesModel = [ISOfertasModel]()
        for c_Cupon in (jsonDataCupones?["promociones"])!{
            
            let asociadoModel = ISAsociadoModel(pId: dimeString(c_Cupon.1["asociado"], nombre: "id"),
                                                pNombre: dimeString(c_Cupon.1["asociado"], nombre: "nombre"),
                                                pDescripcion: dimeString(c_Cupon.1["asociado"], nombre: "descripcion"),
                                                pCondicionesEspeciales: dimeString(c_Cupon.1["asociado"], nombre: "condicionesEspeciales"),
                                                pDireccion: dimeString(c_Cupon.1["asociado"], nombre: "direccion"),
                                                pIdActividad: dimeString(c_Cupon.1["asociado"], nombre: "idActividad"),
                                                pIdLocalidad: dimeString(c_Cupon.1["asociado"], nombre: "idLocalidad"),
                                                pImagen: dimeString(c_Cupon.1["asociado"], nombre: "imagen"),
                                                pTelefonoFijo: dimeString(c_Cupon.1["asociado"], nombre: "telefonoFijo"),
                                                pTelefonoMovil: dimeString(c_Cupon.1["asociado"], nombre: "telefonoMovil"),
                                                pMail: dimeString(c_Cupon.1["asociado"], nombre: "mail"),
                                                pWeb: dimeString(c_Cupon.1["asociado"], nombre: "web"))
            
            
            let promocionesModel = ISOfertasModel(pId: dimeString(c_Cupon.1, nombre: "id"),
                                                  pTipoPromocion: dimeString(c_Cupon.1, nombre: "tipoPromocion"),
                                                  pNombre: dimeString(c_Cupon.1, nombre: "nombre"),
                                                  pImporte: dimeString(c_Cupon.1, nombre: "importe"),
                                                  pImagen: dimeString(c_Cupon.1, nombre: "imagen"),
                                                  pFechaFin: dimeString(c_Cupon.1, nombre: "fechaFin"),
                                                  pMasInformacion: dimeString(c_Cupon.1, nombre: "masInformacion"),
                                                  pAsociado: asociadoModel)
            
            arrayCuponesModel.append(promocionesModel)
        }
        return arrayCuponesModel
    }
}
