//
//  ISRegistrarseViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISRegistrarseViewController: UIViewController {
    
    //MARK: - Variables locales
    var photoSelected = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNombreTF: UITextField!
    @IBOutlet weak var myApellidoTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myMovilTF: UITextField!
    @IBOutlet weak var myActInd: UIActivityIndicatorView!
    
    
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    
    
    @IBAction func singUpACTION(_ sender: Any) {
        
        let sigUp = APISignUp(pUsername: myUsernameTF.text!,
                              pPassword: myPasswordTF.text!,
                              pNombre: myNombreTF.text!,
                              pApellido: myApellidoTF.text!,
                              pEmail: myEmailTF.text!,
                              pMovil: myMovilTF.text!)
        
        do{
            try sigUp.signUpUser()
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }catch{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "Algo salio mal"),
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
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


