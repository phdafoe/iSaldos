//
//  ISLoginViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISLoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myActiINd: UIActivityIndicatorView!
    
    @IBAction func accessApp(_ sender: Any) {
        
        let sigIn = APISignIn(pUsername: myUsernameTF.text!,
                              pPassword: myPasswordTF.text!)
        
        do{
            myActiINd.isHidden = false
            myActiINd.startAnimating()
            try sigIn.signInUser()
            present(muestraAlertVC("Inicio de Sesión",
                                   messageData: "Datos correctos"),
                    animated: true,
                    completion: nil)
        }catch let error{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }catch{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "Algo salio mal"),
                    animated: true,
                    completion: nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Comprobamos que si algun usuario ha accedido
        if PFUser.current() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
