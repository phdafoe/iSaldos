//
//  ISCanalSocialViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import Kingfisher

class ISCanalSocialViewController: UIViewController {
    
    //MARK: - Variables locales
    var nombre = ""
    var apellido = ""
    var imagenPerfil : UIImage?
    var fechaCreacionPost : String?
    
    var dataArray = ["One", "Two", "Three", "Four", "Five"]
    var refreshControl: UIRefreshControl!
    
    
    //var usersFromParse = [UserModel]()
    var userPost = [UserPotImage]()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(otraVez),
                                 for: .valueChanged)
        myTableView.addSubview(refreshControl)
        
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        //TODO: - Registro de celda //ISPostCustomCell
        myTableView.register(UINib(nibName: "SRMiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "SRMiPerfilCustomCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")
        
        informacionUsuario()
        otraVez()
        myTableView.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        informacionUsuario()
        otraVez()
        myTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        informacionUsuario()
        otraVez()
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
        default:
            
            
            
            return userPost.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let customPerfilCell = myTableView.dequeueReusableCell(withIdentifier: "SRMiPerfilCustomCell", for: indexPath) as! SRMiPerfilCustomCell
            
            //nombre y apellido
            customPerfilCell.myNombrePerfilUsuario.text = nombre + " " + apellido
            customPerfilCell.myUsernameSportReviewLBL.text = "@" + (PFUser.current()?.username)!
            
            customPerfilCell.myBotonAjustesPerfilUsuario.tag = indexPath.row
            customPerfilCell.myBotonAjustesPerfilUsuario.addTarget(self,
                                                                   action: #selector(muestraVCConfiguration),
                                                                   for: .touchUpInside)
            customPerfilCell.myFotoPerfilUsuario.image = imagenPerfil
            customPerfilCell.myUsuarioGenerales.tag = indexPath.row
            customPerfilCell.myUsuarioGenerales.addTarget(self,
                                                          action: #selector(muestraTablaUsuarios),
                                                          for: .touchUpInside)
            
            return customPerfilCell
            
        }else{
            let customPostCell = myTableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell", for: indexPath) as! ISPostCustomCell
            
            //let model = usersFromParse[indexPath.row]
            let modelPost = userPost[indexPath.row]
           
            
            customPostCell.myFechaPerfil.text = fechaParse(modelPost.fechaCreacion!)
            customPostCell.myNombreApellidoPerfil.text = modelPost.nombre
            customPostCell.myUsernamePerfil.text = "@" + (PFUser.current()?.username)!

            modelPost.imageProfile?.getDataInBackground(block: { (resultImageData, error) in
                if error == nil{
                    let imageData = UIImage(data:resultImageData!)
                    customPostCell.myImagePerfil.image = imageData
                }else{
                    print("AQUI ERROR")
                }
            })
            
            modelPost.imagePost?.getDataInBackground(block: { (resultPostData, error) in
                if error == nil{
                    let imageData = UIImage(data: resultPostData!)
                    customPostCell.myImagenPostPerfil.image = imageData
                }else{
                    print("AQUI ERROR DOS")
                }
            })
            
            customPostCell.myTextoDescripcionPerfil.text = modelPost.descripcion
            
            
            return customPostCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 305
        }else if indexPath.section == 1{
            return UITableViewAutomaticDimension
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    //MARK: - UTILS
    func informacionUsuario(){
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectsBusqueda, errorBusqueda) in
            if errorBusqueda == nil{
                if let objectData = objectsBusqueda?[0]{
                    self.nombre = (objectData["nombre"] as? String)!
                    self.apellido = (objectData["apellido"] as? String)!
                    //2 consulta
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
                                            self.imagenPerfil = imagenFinal
                                            self.myTableView.reloadData()
                                        }
                                    }
                                    
                                })
                                self.myTableView.reloadData()
                            }
                        }
                        self.myTableView.reloadData()
                    })
                }
                self.myTableView.reloadData()
            }
        })
    }
    
    
    
    func otraVez(){
        let queryPost = PFQuery(className: "PostImageNetwork")
        queryPost.order(byDescending: "createdAt")
        queryPost.findObjectsInBackground(block: { (objcDos, errorDos) in
            if errorDos == nil{
                if let objcDosDes = objcDos{
                    self.userPost.removeAll()
                    for c_objDataPost in objcDosDes{
                        if c_objDataPost["username"] as? String == PFUser.current()?.username{
                            let postFinal = UserPotImage(pNombre: c_objDataPost["nombre"] as! String,
                                                         pApellido: c_objDataPost["apellido"] as! String,
                                                         pUsername: c_objDataPost["username"] as! String,
                                                         pImageProfile: c_objDataPost["imageFilePerfilNW"] as! PFFile,
                                                         pImagePost: c_objDataPost["imageFileNW"] as! PFFile,
                                                         pFechaCreacion: c_objDataPost.createdAt!,
                                                         pDescripcion: c_objDataPost["descripcionImagen"] as! String)
                            
                            self.userPost.append(postFinal)
                        }
                    }
                    self.myTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        })
        self.myTableView.reloadData()
    }
    
    
    
    
    
    
    func muestraVCConfiguration(){
        let configuracionVC = storyboard?.instantiateViewController(withIdentifier: "ConfiguracionPerfilViewController") as! ISConfiguracionPerfilViewController
        configuracionVC.isDelegate = self
        present(configuracionVC,
                animated: true,
                completion: nil)
        
    }
    
    func muestraTablaUsuarios(){
        let tablaUsuarios = storyboard?.instantiateViewController(withIdentifier: "UsuariosTableViewController") as! ISUsuariosTableViewController
        let navController = UINavigationController(rootViewController: tablaUsuarios)
        present(navController,
                animated: true,
                completion: nil)
    }
    
    
    
    
}

extension ISCanalSocialViewController : ISConfiguracionPerfilViewControllerDelegate{
    
    func didProfileChanged() {
        myTableView.reloadData()
    }
}




