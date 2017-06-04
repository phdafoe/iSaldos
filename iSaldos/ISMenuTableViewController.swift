//
//  ISMenuTableViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class ISMenuTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myNombrePerfil: UILabel!
    @IBOutlet weak var myApellidoPerfil: UILabel!
    @IBOutlet weak var myEmailPerfil: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myImagenPerfil.layer.cornerRadius = myImagenPerfil.frame.size.width / 2
        myImagenPerfil.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagenPerfil.layer.borderWidth = 1
        myImagenPerfil.clipsToBounds = true
        
        dameInformacionPerfil()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section==1){
            switch indexPath.row {
            case 2:
                sendMessage()
            case 3:
                showRateAlertInmediatly(self)
            case 4:
                logout()
            default:
                break
            }
        }
        
        
        
        
    }
    
    //MARK: - UTILS
    func logout(){
        performSegue(withIdentifier: "logout", sender: self)
        PFUser.logOutInBackground { (error) -> Void in
            if error != nil{
                print("Error al hacer logout")
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func sendMessage(){
        let mailComposeViewControler = configuredMailComposeViewController()
        mailComposeViewControler.mailComposeDelegate = self
        if MFMailComposeViewController.canSendMail(){
            present(mailComposeViewControler, animated: true, completion: nil)
        }else{
            present(muestraAlertVC("Atención",
                                   messageData: "El mail no se ha enviado correctamente"),
                    animated: true,
                    completion: nil)
        }
    }

    
    

    //MARK: - Utils
    func dameInformacionPerfil(){
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectsBusqueda, errorBusqueda) in
            
            if errorBusqueda == nil{
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
                                }
                            }else{
                                print("Error: \(errorFoto!.localizedDescription) ")
                            }
                        })
                        self.myNombrePerfil.text = objectDataBusqueda["nombre"] as? String
                        self.myApellidoPerfil.text = objectDataBusqueda["apellido"] as? String
                        self.myEmailPerfil.text = objectDataBusqueda["email"] as? String
                        
                    }
                }
            }else{
                self.present(muestraAlertVC("Atención",
                                            messageData: "ha ocurrido un problema en la busqueda de la Base de Datos"),
                             animated: true,
                             completion: nil)
            }
        })
    }
    
    
    

}

//MARK: - DELEGADOS
extension ISMenuTableViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}



