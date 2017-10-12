//
//  ISConfiguracionPerfilViewController.swift
//  iSaldos
//
//  Created by Andres on 14/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

<<<<<<< HEAD
class ISConfiguracionPerfilViewController: UITableViewController {
    
    //MARK: - Variables locales
    var photoSelected = false
    var objectIdFoto : String?
=======

protocol ISConfiguracionPerfilViewControllerDelegate {
    func didProfileChanged()
}

class ISConfiguracionPerfilViewController: UIViewController {
    
    //MARK: - Variables locales
    var photoSelected = false
    var objectIdImageProfile : String?
    var isDelegate : ISConfiguracionPerfilViewControllerDelegate?
>>>>>>> origin/master
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNombreTF: UITextField!
    @IBOutlet weak var myApellidoTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myMovilTF: UITextField!
    @IBOutlet weak var myActInd: UIActivityIndicatorView!
    
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    

    @IBAction func updateDataParse(_ sender: Any) {
        actualizarDatos()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImagenPerfil.layer.cornerRadius = myImagenPerfil.frame.size.width / 2
        myImagenPerfil.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagenPerfil.layer.borderWidth = 1

        myActInd.isHidden = true
        
        myImagenPerfil.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self,
                                           action: #selector(pickerFoto))
        myImagenPerfil.addGestureRecognizer(tapGR)
        
        findDataFromParse()
        // Do any additional setup after loading the view.
    }
    
    

    //MARK: - UTILS
    func findDataFromParse(){
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectsBusqueda, errorBusqueda) in
            if errorBusqueda == nil{
<<<<<<< HEAD
                if let objectData = objectsBusqueda?.first{
                    //2. segunda consulta
                    let queryBusquedaFoto = PFQuery(className: "ImageProfile")
                    queryBusquedaFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryBusquedaFoto.findObjectsInBackground(block: { (objectsBusquedaFoto, errorFoto) in
                        if errorFoto == nil{
                            if let objectsBusquedaFotoData = objectsBusquedaFoto?.first{
                                let userImageFile = objectsBusquedaFotoData["imageProfile"] as! PFFile
                                self.objectIdFoto = objectsBusquedaFotoData.objectId
                                userImageFile.getDataInBackground(block: { (imageData, errorImageData) in
                                    if errorImageData == nil{
                                        if let imageDataDesempaquetado = imageData{
                                            let imagenFinal = UIImage(data: imageDataDesempaquetado)
                                            self.myImagenPerfil.image = imagenFinal
                                        }
                                    }else{
                                        print("Hola chicos no tenemos imagen :(")
=======
                if let objectData = objectsBusqueda{
                    for objectDataBusqueda in objectData{
                        
                        //2. segunda consulta
                        let queryBusquedaFoto = PFQuery(className: "ImageProfile")
                        queryBusquedaFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                        queryBusquedaFoto.findObjectsInBackground(block: { (objectsBusquedaFoto, errorFoto) in
                            if errorFoto == nil{
                                if let objectsBusquedaFotoData = objectsBusquedaFoto{
                                    for objectsBusquedaFotoBucle in objectsBusquedaFotoData{
                                        let userImageFile = objectsBusquedaFotoBucle["imageProfile"] as! PFFile
                                        self.objectIdImageProfile = objectsBusquedaFotoBucle.objectId
                                        //3. tercera consulta
                                        userImageFile.getDataInBackground(block: { (imageData, errorImageData) in
                                            if errorImageData == nil{
                                                if let imageDataDesempaquetado = imageData{
                                                    let imagenFinal = UIImage(data: imageDataDesempaquetado)
                                                    self.myImagenPerfil.image = imagenFinal
                                                }
                                            }else{
                                                print("Hola chicos no tenemos imagen :(")
                                            }
                                        })
>>>>>>> origin/master
                                    }
                                })
                            }
<<<<<<< HEAD
                        }else{
                            print("Error: \(errorFoto!.localizedDescription) ")
                        }
                    })
                    self.myNombreTF.text = objectData["nombre"] as? String
                    self.myApellidoTF.text = objectData["apellido"] as? String
                    self.myUsernameTF.text = PFUser.current()?.username
                    self.myPasswordTF.text = PFUser.current()?.password
                    self.myEmailTF.text = PFUser.current()?.email
                    self.myMovilTF.text = objectData["movil"] as? String
=======
                        })
                        self.myNombreTF.text = objectDataBusqueda["nombre"] as? String
                        self.myApellidoTF.text = objectDataBusqueda["apellido"] as? String
                        self.myUsernameTF.text = PFUser.current()?.username
                        self.myPasswordTF.text = PFUser.current()?.password
                        self.myEmailTF.text = PFUser.current()?.email
                        self.myMovilTF.text = objectDataBusqueda["movil"] as? String
                    }
>>>>>>> origin/master
                }
            }else{
                self.present(muestraAlertVC("Hola",
                                            messageData: "Ha ocurrido un problema  en la busqueda de datos"),
                             animated: true,
                             completion: nil)
            }
        })
    }
    
    //TODO: - FUNC ACTUALIZAR DATOS
    func actualizarDatos(){
        
<<<<<<< HEAD
        if myImagenPerfil.image != nil{
            let userUpdateData = PFUser.current()!
            userUpdateData["nombre"] = myNombreTF.text
            userUpdateData["apellido"] = myApellidoTF.text
            userUpdateData.email = myEmailTF.text
            userUpdateData["movil"] = myMovilTF.text
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            myActInd.isHidden = false
            myActInd.startAnimating()
            userUpdateData.saveInBackground { (exitoActualizacion, errorActualizacion) in
                self.myActInd.isHidden = true
                self.myActInd.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if exitoActualizacion{
                    print("se han actualizado correctamente los datos")
                    self.updatePhoto()
                }else{
                    self.present(muestraAlertVC("Hola",
                                                messageData: "\(String(describing: errorActualizacion!.localizedDescription))"),
                                 animated: true,
                                 completion: nil)
                }
=======
        let userUpdateData = PFUser.current()!
        userUpdateData["nombre"] = myNombreTF.text
        userUpdateData["apellido"] = myApellidoTF.text
        userUpdateData.email = myEmailTF.text
        userUpdateData["movil"] = myMovilTF.text
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        myActInd.isHidden = false
        myActInd.startAnimating()
        userUpdateData.saveInBackground { (exitoActualizacion, errorActualizacion) in
            self.myActInd.isHidden = true
            self.myActInd.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if exitoActualizacion{
                print("se han actualizado correctamente los datos")
                self.updateFoto()
                self.isDelegate?.didProfileChanged()
            }else{
                self.present(muestraAlertVC("Hola",
                                            messageData: "\(String(describing: errorActualizacion?.localizedDescription))"),
                             animated: true,
                             completion: nil)
>>>>>>> origin/master
            }
        }
        
    }
    
    
<<<<<<< HEAD
    func updatePhoto(){
        let imageProfile = PFObject(className: "ImageProfile")
        imageProfile.objectId = objectIdFoto
        let imageDataprofile = UIImageJPEGRepresentation(myImagenPerfil.image!, 0.5)
        let imageProfileFile = PFFile(name: "ImageProfile.jpg", data: imageDataprofile!)
        imageProfile["imageProfile"] = imageProfileFile
        imageProfile["username"] = PFUser.current()?.username
        imageProfile.saveInBackground{ (exitoso, error) in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
                self.photoSelected = false
                self.myUsernameTF.text = ""
                self.myPasswordTF.text = ""
                self.myNombreTF.text = ""
                self.myApellidoTF.text = ""
                self.myEmailTF.text = ""
                self.myMovilTF.text = ""
                self.myImagenPerfil.image = #imageLiteral(resourceName: "placeholderPerson")
=======
    
    //MARK: - SUBIR FOTO A PARSE CON EL REGISTRO
    func updateFoto(){
        //instancia de la imagen a subir
        let postImage = PFObject(className: "ImageProfile")
        postImage.objectId = objectIdImageProfile
        let imageData = UIImageJPEGRepresentation(self.myImagenPerfil.image!, 0.4)
        let imageFile = PFFile(name: "userImageProfile.jpg", data: imageData!)
        postImage["imageProfile"] = imageFile
        postImage["username"] = PFUser.current()?.username
        postImage.saveInBackground { (success, error) in
            if success{
                self.isDelegate?.didProfileChanged()
                print("DATOS SALVADOS SATISFACTORIAMENTE")
                self.dismiss(animated: true,
                             completion: nil)
            }else{
                print("Error en el registro")
>>>>>>> origin/master
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    
}

//MARK: - EXTENSION
extension ISConfiguracionPerfilViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickerFoto(){
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
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImagenPerfil.image = imageData
            if myImagenPerfil.image != nil{
                photoSelected = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}




