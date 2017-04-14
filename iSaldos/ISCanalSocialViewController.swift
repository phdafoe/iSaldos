//
//  ISCanalSocialViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISCanalSocialViewController: UIViewController {
    
    //MARK: - Variables locales
    var nombre : String?
    var apellido : String?
    var imagenPerfil : UIImage?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        
        //TODO: - Registro de celda
        myTableView.register(UINib(nibName: "SRMiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "SRMiPerfilCustomCell")
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findDataFromParse()
        myTableView.reloadData()
    }
    

    

}

extension ISCanalSocialViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 4
        }
        
        /*if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            if listaMuros.count == 0{
                return 1
            }
            return listaMuros.count
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let customPerfilCell = myTableView.dequeueReusableCell(withIdentifier: "SRMiPerfilCustomCell", for: indexPath) as! SRMiPerfilCustomCell
            
            //nombre y apellido
            customPerfilCell.myNombrePerfilUsuario.text = nombre
            customPerfilCell.myUsernameSportReviewLBL.text = apellido
            
            customPerfilCell.myBotonAjustesPerfilUsuario.tag = indexPath.row
            customPerfilCell.myBotonAjustesPerfilUsuario.addTarget(self,
                                                                   action: #selector(muestraVCConfiguration),
                                                                   for: .touchUpInside)
            
            
            customPerfilCell.myFotoPerfilUsuario.image = imagenPerfil

            
            
            return customPerfilCell
            
        }else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0{
            return 305
        }else if (indexPath as NSIndexPath).section == 1{
            return UITableViewAutomaticDimension
            //return 20
        }else{
            /*if listaMuros.count == 0{
                return 320
            }
            
            let muro = listaMuros[(indexPath as NSIndexPath).row]
            return SRRestCliente().dameCellSize(muro: muro)*/
            return CGFloat()
            
        }
    }
    
    
    //MARK: - UTILS
    func findDataFromParse(){
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
                                            let userImageFile = objectsBusquedaFotoBucle["imageFile"] as! PFFile
                                            //3. tercera consulta
                                            userImageFile.getDataInBackground(block: { (imageData, errorImageData) in
                                                if errorImageData == nil{
                                                    if let imageDataDesempaquetado = imageData{
                                                        let imagenFinal = UIImage(data: imageDataDesempaquetado)
                                                        self.imagenPerfil = imagenFinal
                                                    }
                                                }else{
                                                    print("Hola chicos no tenemos imagen :(")
                                                }
                                            })
                                        }
                                    }
                                }else{
                                    print("Error: \(errorFoto!) ")
                                }
                            })
                            self.nombre = objectDataBusqueda["nombre"] as? String
                            self.apellido = objectDataBusqueda["apellido"] as? String
                    }
                    self.myTableView.reloadData()
                }
            }else{
                self.present(muestraAlertVC("Hola",
                                            messageData: "Ha ocurrido un problema  en la busqueda de datos"),
                             animated: true,
                             completion: nil)
            }
        })
    }
    
    func muestraVCConfiguration(){
        let configuracionVC = storyboard?.instantiateViewController(withIdentifier: "ConfiguracionPerfilViewController") as! ISConfiguracionPerfilViewController
        present(configuracionVC,
                animated: true,
                completion: nil)
        
    }
    
    
    
    
}
