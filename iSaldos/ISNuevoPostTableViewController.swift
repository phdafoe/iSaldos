//
//  ISNuevoPostTableViewController.swift
//  iSaldos
//
//  Created by Andres on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISNuevoPostTableViewController: UITableViewController {
    
    
    //MARK: - Variables locales
    var fotoSeleccionada = false
    let fechaHumana = Date()
   
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsernamePerfil: UILabel!
    @IBOutlet weak var myFechaHumanoPerfil: UILabel!
    @IBOutlet weak var myImagenPost: UIImageView!
    @IBOutlet weak var myDescripcionFotoTip: UITextView!
    @IBOutlet weak var ocultarImagenBTN: UIButton!
    @IBOutlet weak var myNombreApellido: UILabel!
    
    @IBOutlet weak var myApellido: UILabel!
    
    //MARK: - IBActions
    @IBAction func ocultarVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        myDescripcionFotoTip.delegate = self
        
        
        //Bloque toolBar
        let barraFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let colorWB = UIColor.white
        let colorB = CONSTANTES.COLORES.GRIS_NAV_TAB
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.tintColor = colorWB
        toolBar.barTintColor = colorB
        
        let camera = UIBarButtonItem(image: UIImage(named:"camara"), style: .done, target: self, action: #selector(self.pickerFoto))
        let salvarDatos = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(self.salvarDatos))
        
        toolBar.items = [camera, barraFlexible, salvarDatos]
        myDescripcionFotoTip.inputAccessoryView = toolBar
        
        
        let customDateFormater = DateFormatter()
        customDateFormater.dateStyle = .medium
        myFechaHumanoPerfil.text = "fecha" + " " + customDateFormater.string(from: fechaHumana)
        
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.bajarTeclado))
        tableView.addGestureRecognizer(gestureRecog)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myDescripcionFotoTip.becomeFirstResponder()
        dameInformacionPerfil()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func salvarDatos(){
        var errorData = ""
        
        if !fotoSeleccionada{
            errorData = "Por favor elige una foto de la galeria o toma una fotografia"
        }else if myDescripcionFotoTip.text == ""{
            errorData = "Por favor introduce una breve descripcion de la imagen"
        }
        
        if errorData != ""{
            present(muestraAlertVC("Error en los datos",
                                   messageData: errorData),
                    animated: true,
                    completion: nil)
        }else{
            let postImage = PFObject(className: "PostImageNetwork")
            let imageData = UIImageJPEGRepresentation(self.myImagenPost.image!, 0.1)
            let imageFile = PFFile(name: "image.jpg", data: imageData!)
            
            let imageDataPerfil = UIImageJPEGRepresentation(self.myImagenPerfil.image!, 0.1)
            let imageFilePerfil = PFFile(name: "imagePerfil.jpg", data: imageDataPerfil!)
            
            postImage["imageFileNW"] = imageFile
            postImage["imageFilePerfilNW"] = imageFilePerfil
            
            postImage["username"] = PFUser.current()?.username
            postImage["descripcionImagen"] = myDescripcionFotoTip.text
            postImage["nombre"] = myNombreApellido.text
            postImage["apellido"] = myNombreApellido.text
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            postImage.saveInBackground(block: { (subidaExitosaFoto, errorSubidaFoto) in
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if subidaExitosaFoto{
//                    self.present(muestraAlertVC("Estimado usuario",
//                                           messageData: "se ha logrado subir exitosamente la foto"),
//                            animated: true,
//                            completion: nil)
                    self.dismiss(animated: true, completion: nil)
                }else{
                    
//                    self.present(muestraAlertVC("Estimado usuario",
//                                           messageData: "NO se ha logrado subir exitosamente la foto"),
//                            animated: true,
//                            completion: nil)
                }
                self.fotoSeleccionada = false
                self.myDescripcionFotoTip.text = ""
                self.myImagenPost.image = UIImage(named: "placeholder")
            })
        }
    }
    
    
    //MARK: - Utils
    func dameInformacionPerfil(){
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectsBusqueda, errorBusqueda) in
            
            if errorBusqueda == nil{
                if let objectData = objectsBusqueda?[0]{
                    
                    let nombre = objectData["nombre"] as? String
                    let apellido = objectData["apellido"] as? String
                    
                    self.myNombreApellido.text = nombre
                    self.myApellido.text = apellido
                    self.myUsernamePerfil.text = "@" + (PFUser.current()?.username!)!
                    
                    //2. segunda consulta
                    let queryBusquedaFoto = PFQuery(className: "ImageProfile")
                    queryBusquedaFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryBusquedaFoto.findObjectsInBackground(block: { (objectsBusquedaFoto, errorFoto) in
                        if errorFoto == nil{
                            if let objectsBusquedaFotoData = objectsBusquedaFoto?[0]{
                                let userImageFile = objectsBusquedaFotoData["imageProfile"] as! PFFile
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
                            }
                        }else{
                            print("Error: \(errorFoto!.localizedDescription) ")
                        }
                    })
                }
            }else{
                self.present(muestraAlertVC("Atención",
                                            messageData: "ha ocurrido un problema en la busqueda de la Base de Datos"),
                             animated: true,
                             completion: nil)
            }
        })
    }
    
    
    @objc func bajarTeclado(){
        myDescripcionFotoTip.resignFirstResponder()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    

}

//MARK: - EXTENSION
extension ISNuevoPostTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func pickerFoto(){
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
            myImagenPost.image = imageData
            fotoSeleccionada = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - DELEGATE UITEXTVIEW
extension ISNuevoPostTableViewController : UITextViewDelegate{
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "¿Qué está pasando?"
            textView.textColor = UIColor.lightGray
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxtext: Int = 2000
        let comoVoy = myDescripcionFotoTip.text.characters.count + (text.characters.count - range.length)
        //myContadorNegativoLBL.text = String(2000 - comoVoy)
        return comoVoy < maxtext
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
        
    }
    
}




