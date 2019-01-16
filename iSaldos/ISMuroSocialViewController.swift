//
//  ISMuroSocialViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import Kingfisher
import APESuperHUD

class ISMuroSocialViewController: UIViewController {
    
    //MARK: - Variables locales
    var nombre : String?
    var apellido : String?
    var imagenPerfil : UIImage?
    var fechaCreacionPost : String?
    
    var refreshControl: UIRefreshControl!
    
    var dataArrayDenuncia = ["¿Por qué lo denuncias?", "Creo que esto es inapropiado", "Creo que la información es falsa, fraudulenta o no deseada", "Creo que es otra cosa diferente"]
    
    
    @IBOutlet weak var myVistaDenuncia: UIView!
    @IBAction func cierraVistaDenuncia(_ sender: Any) {
        UIView.animate(withDuration: 0.03) {
            self.myVistaDenuncia.isHidden = true
        }
    }
    @IBOutlet weak var myTableViewDenuncia: UITableView!
    
    //var usersFromParse = [UserModel]()
    var userPost = [UserPotImage]()
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myVistaDenuncia.isHidden = true
        myVistaDenuncia.layer.cornerRadius = 10
        myVistaDenuncia.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myVistaDenuncia.layer.borderWidth = 1
        myVistaDenuncia.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myVistaDenuncia.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(getDataPostFromParse),
                                 for: .valueChanged)
        myTableView.addSubview(refreshControl)
        
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableViewDenuncia.delegate = self
        myTableViewDenuncia.dataSource = self
        
        
        //TODO: - Registro de celda //ISPostCustomCell
        myTableView.register(UINib(nibName: "SRMiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "SRMiPerfilCustomCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")
        myTableViewDenuncia.register(UINib(nibName: "DenunciaCell", bundle: nil), forCellReuseIdentifier: "DenunciaCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        getDataPostFromParse()
        
    }
    
}



extension ISMuroSocialViewController : UITableViewDelegate, UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == myTableView{
           return 1
        }else{
            return 1
        }
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myTableView{
            return userPost.count
        }else{
            return dataArrayDenuncia.count
        }
      
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myTableView{
            let customPostCell = myTableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell", for: indexPath) as! ISPostCustomCell
            
            let modelPost = userPost[indexPath.row]
            
            customPostCell.myFechaPerfil.text = fechaParse(modelPost.fechaCreacion!)
            customPostCell.myNombreApellidoPerfil.text = modelPost.nombre
            customPostCell.myUsernamePerfil.text = "@" + (PFUser.current()?.username)!
            customPostCell.myDenunciaButton.tag = indexPath.row
            customPostCell.myDenunciaButton.addTarget(self, action: #selector(muestraAlertaDenuncia(_ :)), for: .touchUpInside)
            
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
        }else{
            let cellDenuncia = myTableViewDenuncia.dequeueReusableCell(withIdentifier: "DenunciaCell", for: indexPath) as! DenunciaCell
            cellDenuncia.myDenunciaLBL.text = dataArrayDenuncia[indexPath.row]
            return cellDenuncia
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == myTableViewDenuncia{
            self.myVistaDenuncia.isHidden = true
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == myTableViewDenuncia{
            return 60
        }else{
            return UITableViewAutomaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    @objc func getDataPostFromParse(){
        let queryPost = PFQuery(className: "PostImageNetwork")
        queryPost.order(byDescending: "createdAt")
        //queryPost.whereKey("username", notEqualTo: (PFUser.current()?.username)!)
        APESuperHUD.show(style: HUDStyle.textOnly, title: nil, message: "Cargando..", completion: nil)
        queryPost.findObjectsInBackground(block: { (objcDos, errorDos) in
            if errorDos == nil{
                
                if let objcDosDes = objcDos{
                    
                    self.userPost.removeAll()
                    
                    for c_objDataPost in objcDosDes{
                        
                        let postFinal = UserPotImage(pNombre: c_objDataPost["nombre"] as! String,
                                                     pApellido: c_objDataPost["apellido"] as! String,
                                                     pUsername: c_objDataPost["username"] as! String,
                                                     pImageProfile: c_objDataPost["imageFilePerfilNW"] as! PFFileObject,
                                                     pImagePost: c_objDataPost["imageFileNW"] as! PFFileObject,
                                                     pFechaCreacion: c_objDataPost.createdAt!,
                                                     pDescripcion: c_objDataPost["descripcionImagen"] as! String)
                        
                        self.userPost.append(postFinal)
                    }
                 self.myTableView.reloadData()
                    APESuperHUD.dismissAll(animated: true)
                    self.refreshControl.endRefreshing()
                }
            }
        })
    }
    
    
    
    @objc func muestraAlertaDenuncia(_ sender : UIButton){
        
        let modelPost = userPost[sender.tag]
        let nombrePublicacion = modelPost.nombre
        var imageData : UIImage?
        modelPost.imagePost?.getDataInBackground(block: { (resultPostData, error) in
            if error == nil{
                imageData = UIImage(data: resultPostData!)
            }else{
                print("AQUI ERROR DOS")
            }
        })
        
        let optionMenu = UIAlertController(title: nil, message: "Elija la opción", preferredStyle: .actionSheet)
        let actionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let actionDenunciar = UIAlertAction(title: "Denunciar esta publicación", style: .default, handler: {(action) in
            UIView.animate(withDuration: 0.3, animations: {
                self.myVistaDenuncia.isHidden = false
            })
        })
        let actionCompartir = UIAlertAction(title: "Compartir por", style: .default) { (action) in
            let compartirVC = UIActivityViewController(activityItems: [nombrePublicacion!, imageData!], applicationActivities: nil)
            self.present(compartirVC, animated: true, completion: nil)
        }
        
        optionMenu.addAction(actionCancelar)
        optionMenu.addAction(actionDenunciar)
        optionMenu.addAction(actionCompartir)
        present(optionMenu, animated: true, completion: nil)

    }
    
    
    
    
    
}
