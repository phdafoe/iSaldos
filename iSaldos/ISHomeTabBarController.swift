//
//  ISHomeTabBarController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

var tabBarRoot : ISHomeTabBarController?

class ISHomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarRoot = self
        print("abro web : \(abroWeb)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func abroWebNotificacion(){
        if enlace != ""{
            let webDetallePublicidad = self.storyboard?.instantiateViewController(withIdentifier: "ISWebViewController") as! ISWebViewController
            //let navController = UINavigationController(rootViewController: webDetallePublicidad)
            webDetallePublicidad.detalleWebPublicidad = enlace
            webDetallePublicidad.detalleTitulo = "ISALDOS"
            self.present(webDetallePublicidad, animated: true, completion: nil)
        }
        
    }

}
