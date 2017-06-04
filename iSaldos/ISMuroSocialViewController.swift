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

class ISMuroSocialViewController: UIViewController {
    
    
    var refreshControl: UIRefreshControl!
    var userPost = [UserPotImage]()
    var usersFollowing = [Bool]()
    
    
    
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
        
       
        
        myTableView.register(UINib(nibName: "ISNoPostCusotmCell", bundle: nil), forCellReuseIdentifier: "ISNoPostCusotmCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        otraVez()
        
    }
    
}



extension ISMuroSocialViewController : UITableViewDelegate, UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if userPost.count == 0{
            let imageBackgroundList = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
            imageBackgroundList.contentMode = .scaleAspectFit
            myTableView.backgroundView = imageBackgroundList
        }else{
            myTableView.backgroundView = UIView()
        }
        return userPost.count
        
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let customPostCell = myTableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell", for: indexPath) as! ISPostCustomCell
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
       
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func otraVez(){
        let queryPost = PFQuery(className: "PostImageNetwork")
        queryPost.order(byDescending: "createdAt")
        queryPost.findObjectsInBackground(block: { (objcDos, errorDos) in
            if errorDos == nil{
                
                if let objcDosDes = objcDos{
                    
                    self.userPost.removeAll()
                    
                    for c_objDataPost in objcDosDes{
                        let postFinal = UserPotImage(pNombre: c_objDataPost["nombre"] as! String,
                                                     pApellido: c_objDataPost["apellido"] as! String,
                                                     pUsername: c_objDataPost["username"] as! String,
                                                     pImageProfile: c_objDataPost["imageFilePerfilNW"] as! PFFile,
                                                     pImagePost: c_objDataPost["imageFileNW"] as! PFFile,
                                                     pFechaCreacion: c_objDataPost.createdAt!,
                                                     pDescripcion: c_objDataPost["descripcionImagen"] as! String)
                        
                        self.userPost.append(postFinal)
                    }
                    self.myTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        })
    }

    
    
    
    
}
