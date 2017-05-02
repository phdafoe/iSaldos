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








