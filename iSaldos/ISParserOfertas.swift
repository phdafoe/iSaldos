//
//  ISParserOfertas.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ISParserOfertas: NSObject {
    
    /*http://app.clubsinergias.es/api_comercios.php?idlocalidad=11&tipo=oferta&p=promociones
    CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASEIDLOCALIDAD + idLocalidad + CONSTANTES.LLAMADAS.BASEIDTIPO + idTipo + CONSTANTES.LLAMADAS.BASEIDP + idParametro*/
    //http://andresocampo.com/pruebas/iSaldos/concursos.json
    
    
    
    
    
    var jsonDataPromociones : JSON?
    
    func getDatosPromociones(_ idLocalidad : String, idTipo : String, idParametro : String) -> Promise<JSON>{
        let request = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_URL_OFERTAS)!)
        print(request)
        
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            self.jsonDataPromociones = JSON(data)
            return self.jsonDataPromociones!
        }
    }
    
    func getParserPromociones() -> [ISOfertasModel]{
        var arrayPromocionesModel = [ISOfertasModel]()
        for c_Promocion in (jsonDataPromociones?["promociones"])!{
            
            let asociadoModel = ISAsociadoModel(pId: dimeString(c_Promocion.1["asociado"], nombre: "id"),
                                                pNombre: dimeString(c_Promocion.1["asociado"], nombre: "nombre"),
                                                pDescripcion: dimeString(c_Promocion.1["asociado"], nombre: "descripcion"),
                                                pCondicionesEspeciales: dimeString(c_Promocion.1["asociado"], nombre: "condicionesEspeciales"),
                                                pDireccion: dimeString(c_Promocion.1["asociado"], nombre: "direccion"),
                                                pIdActividad: dimeString(c_Promocion.1["asociado"], nombre: "idActividad"),
                                                pIdLocalidad: dimeString(c_Promocion.1["asociado"], nombre: "idLocalidad"),
                                                pImagen: dimeString(c_Promocion.1["asociado"], nombre: "imagen"),
                                                pTelefonoFijo: dimeString(c_Promocion.1["asociado"], nombre: "telefonoFijo"),
                                                pTelefonoMovil: dimeString(c_Promocion.1["asociado"], nombre: "telefonoMovil"),
                                                pMail: dimeString(c_Promocion.1["asociado"], nombre: "mail"),
                                                pWeb: dimeString(c_Promocion.1["asociado"], nombre: "web"))
            
            
            let promocionesModel = ISOfertasModel(pId: dimeString(c_Promocion.1, nombre: "id"),
                                                  pTipoPromocion: dimeString(c_Promocion.1, nombre: "tipoPromocion"),
                                                  pNombre: dimeString(c_Promocion.1, nombre: "nombre"),
                                                  pImporte: dimeString(c_Promocion.1, nombre: "importe"),
                                                  pImagen: dimeString(c_Promocion.1, nombre: "imagen"),
                                                  pFechaFin: dimeString(c_Promocion.1, nombre: "fechaFin"),
                                                  pMasInformacion: dimeString(c_Promocion.1, nombre: "masInformacion"),
                                                  pAsociado: asociadoModel)
            
            arrayPromocionesModel.append(promocionesModel)
        }
        return arrayPromocionesModel
    }
    
    
    
    
    
    
    
    
    
    

}
