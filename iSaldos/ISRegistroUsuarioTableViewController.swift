//
//  ISRegistroUsuarioTableViewController.swift
//  iSaldos
//
//  Created by Andres on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISRegistroUsuarioTableViewController: UITableViewController {
    
    
    
    //MARK: - Variables locales
    var photoSelected = false
    
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
        
        var errorInicial = ""
        if myImagenPerfil.image == nil || myUsernameTF.text == "" || myPasswordTF.text == "" || myNombreTF.text == "" || myApellidoTF.text == "" || myEmailTF.text == ""{
            
            errorInicial = "Estimado usuario por favor rellene todos los campos"
            
        }else{
            
            let newUser = PFUser()
            newUser.username = myUsernameTF.text
            newUser.password = myPasswordTF.text
            newUser.email = myEmailTF.text
            newUser["nombre"] = myNombreTF.text
            newUser["apellido"] = myApellidoTF.text
            newUser["movil"] = myMovilTF.text
            
            myActInd.isHidden = false
            myActInd.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            newUser.signUpInBackground(block: { (exitoso, errorRegistro) in
                
                self.myActInd.isHidden = true
                self.myActInd.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil{
                    self.present(muestraAlertVC("Atención",
                                                messageData: "Error al registrar"),
                                 animated: true,
                                 completion: nil)
                }else{
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
                }
            })
        }
        
        if errorInicial != ""{
            present(muestraAlertVC("Atención",
                                   messageData: errorInicial),
                    animated: true,
                    completion: nil)
        }
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImagenPerfil.isUserInteractionEnabled = true
        let tapGRUno = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagenPerfil.addGestureRecognizer(tapGRUno)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }
    }

    
    
    func signUpWithPhoto(){
        
        if photoSelected {
            let imageProfile = PFObject(className: "ImageProfile")
            let imageDataProfile = UIImageJPEGRepresentation(myImagenPerfil.image!, 0.5)
            let imageProfileFile = PFFileObject(name: "userImageProfile.jpg", data: imageDataProfile!)
            imageProfile["imageProfile"] = imageProfileFile
            imageProfile["username"] = PFUser.current()?.username
            
            imageProfile.saveInBackground()
            
            self.photoSelected = false
            self.myUsernameTF.text = ""
            self.myPasswordTF.text = ""
            self.myNombreTF.text = ""
            self.myApellidoTF.text = ""
            self.myEmailTF.text = ""
            self.myMovilTF.text = ""
            self.myImagenPerfil.image = #imageLiteral(resourceName: "placeholderPerson")
        }else{
            self.present(muestraAlertVC("Atención",
                                        messageData: "Foto no seleccionada"),
                         animated: true,
                         completion: nil)
        }
        
    }
    

}
//MARK: - EXTENSION
extension ISRegistroUsuarioTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreria()
        }
    }
    
    func muestraMenu(){
        let menuVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        menuVC.addAction(UIAlertAction(title: "Camara de Fotos", style: .default, handler: { Void in
            self.muestraCamaraFotos()
        }))
        menuVC.addAction(UIAlertAction(title: "Libreria de Fotos", style: .default, handler: { Void in
            self.muestraLibreria()
        }))
        present(menuVC, animated: true, completion: nil)
    }
    
    
    func muestraLibreria(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            myImagenPerfil.image = possibleImage
            self.photoSelected = true
        } 
        
        dismiss(animated: true, completion: nil)
    }
    
}


