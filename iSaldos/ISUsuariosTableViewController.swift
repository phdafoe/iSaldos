//
//  ISUsuariosTableViewController.swift
//  iSaldos
//
//  Created by Andres on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISUsuariosTableViewController: UITableViewController {
    
    //MARK: - VARIABLES LOCALES GLOBALES
    var userName : [String] = []
    var nombreYApellido : [String] = []
    var usersFollowing = [Bool]()
    var objectIdFoto : String?
    
    
    
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //dameInformacionPerfil()
        actualizarDatosUsuariosSeguidos()
        self.title = PFUser.current()?.username
        
        tableView.register(UINib(nibName: "ISUsuariosCustomCell", bundle: nil), forCellReuseIdentifier: "ISUsuariosCustomCell")
    
    }
    
    //MARK: - Utils
    func dameInformacionPerfil(){
        let queryUsuariosFromParse = PFUser.query()
        queryUsuariosFromParse?.findObjectsInBackground{ (objectsUsuarios, errorUsuarios) in
            self.userName.removeAll()
                if errorUsuarios == nil{
                    for objectsData in objectsUsuarios!{
                        let userData = objectsData as! PFUser
                        self.userName.append(userData.username!)
                    }
                    self.tableView.reloadData()
                }
            }
    }
    
    
    func actualizarDatosUsuariosSeguidos(){
        //1. Consulta a Followers
        let queryFollowers = PFQuery(className: "Followers")
        queryFollowers.whereKey("follower", equalTo: (PFUser.current()?.username)!)
        queryFollowers.findObjectsInBackground { (objectFollowers, errorFollowers) in
            if errorFollowers == nil{
                if let followingPersonas = objectFollowers{
                    //2. consulta de PFQuery
                    let queryUsuariosFromParse = PFUser.query()
                    queryUsuariosFromParse?.findObjectsInBackground{ (objectsUsuarios, errorUsuarios) in
                        self.userName.removeAll()
                        self.usersFollowing.removeAll()
                        if errorUsuarios == nil{
                            for objectsData in objectsUsuarios!{
                                //3. Consulta
                                let userData = objectsData as! PFUser
                                if userData.username != PFUser.current()?.username{
                                    self.userName.append(userData.username!)
                                    self.nombreYApellido.append(userData["nombre"] as! String)
                                    self.nombreYApellido.append(userData["apellido"] as! String)
                                    
                                    var isFollowing = false
                                    for c_followingPersonaje in followingPersonas{
                                        if c_followingPersonaje["following"] as? String == userData.username{
                                            isFollowing = true
                                        }
                                    }
                                    self.usersFollowing.append(isFollowing)
                                    self.tableView.reloadData()
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
            }else{
                print("Error: \(String(describing: errorFollowers?.localizedDescription))")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ISUsuariosCustomCell", for: indexPath) as! ISUsuariosCustomCell

        // Configure the cell...
        let modelData = userName[indexPath.row]
        let modelNombre = nombreYApellido[indexPath.row]
        let followingData = usersFollowing[indexPath.row]
        
        cell.myNombre.text = modelNombre
        //cell.myApellido.text = modelNombre
        cell.myUsername.text = modelData
        
//        modelData.imageProfile?.getDataInBackground(block: { (dataImage, errorImage) in
//            if errorImage == nil{
//                let imageDown = UIImage(data: dataImage!)
//                cell.myImagenPerfil.image = imageDown
//            }else{
//                print("Error AQUI")
//            }
//
//        })
        
        if followingData{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ISUsuariosCustomCell
        
        if cell.accessoryType == UITableViewCellAccessoryType.checkmark{
            cell.accessoryType = UITableViewCellAccessoryType.none
            let queryFollowing = PFQuery(className: "Followers")
            queryFollowing.whereKey("follower", equalTo: (PFUser.current()?.username)!)
            queryFollowing.whereKey("following", equalTo: (cell.myUsername.text)!)
            queryFollowing.findObjectsInBackground(block: { (objectFollowers, errorFollowers) in
                if errorFollowers == nil{
                    if let objectFollowersData = objectFollowers{
                        for object in objectFollowersData{
                            object.deleteInBackground(block: nil)
                        }
                    }
                }else{
                    print("Error: \(String(describing: errorFollowers?.localizedDescription))")
                }
            })
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            let following = PFObject(className: "Followers")
            following["following"] = cell.myUsername.text
            following["follower"] = PFUser.current()?.username
            following.saveInBackground(block: nil)
        }
    }
    
    
    

}
