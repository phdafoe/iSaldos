//
//  APIHELPERS.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON
import MessageUI



let customPrefs = UserDefaults.standard
private let dateFormatter = DateFormatter()


func muestraAlertVC(_ titleData : String, messageData : String) -> UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
}


//MARK: - ENVIO DE CORREO DE CONTACTO
func configuredMailComposeViewController() -> MFMailComposeViewController{
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients(["info@info.com"])
    mailCompose.setSubject("Ayuda desde IOS")
    mailCompose.setMessageBody("Escriba su mensaje, nos pondremos en contacto con usted lo antes posible.", isHTML: false)
    return mailCompose
}



//MARK: - NULL TO STRING
public func dimeString(_ j : JSON, nombre : String) -> String{
    if let stringResult = j[nombre].string{
        return stringResult
    }else{
        return ""
    }
}

//MARK: - NULL TO INT
public func dimeInt(_ j : JSON, nombre : String) -> Int{
    if let intResult = j[nombre].int{
        return intResult
    }else{
        return 0
    }
}

//MARK: - NULL TO DOUBLE
public func dimeDouble(_ j : JSON, nombre : String) -> Double{
    if let doubleResult = j[nombre].double{
        return doubleResult
    }else{
        return 0
    }
}

//MARK: - NULL TO BOOL
public func dimeBool(_ j : JSON, nombre : String) -> Bool{
    if let boolResult = j[nombre].bool{
        return boolResult
    }else{
        return false
    }
}


public func fechaParse(_ fecha : Date) -> String{
    dateFormatter.dateFormat = "EEE, dd MMM"
    dateFormatter.locale = Locale(identifier: "es_ES")
    return dateFormatter.string(from: fecha)
}

public func dameFecha(_ fecha : Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM"
    dateFormatter.locale = Locale(identifier: "es_ES")
    return dateFormatter.string(from: fecha)
}


public func randonNumber () -> String{
    let arrayNumber = 1 + Int(arc4random_uniform(100))
    return "\(arrayNumber)"
}

func getImagePath() -> String{
    return CONSTANTES.LLAMADAS.BASE_URL_IMAGE_TMDB
}










