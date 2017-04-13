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
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
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
            myActInd.isHidden = false
            myActInd.startAnimating()
            try sigUp.signUpUser()
            present(muestraAlertVC("Registrado",
                                   messageData: "Los datos se salvaron correctamente"),
                    animated: true,
                    completion: { _ in
                        self.myActInd.isHidden = true
                        self.myActInd.stopAnimating()
                        self.performSegue(withIdentifier: "jumpToViewContoller", sender: self) })
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
