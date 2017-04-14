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
        PFUser.logOut()
        dismiss(animated: true,
                completion: nil)
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
        //let queryInfo = PFQuery(className: <#T##String#>)
    }
    
    
    

}

//MARK: - DELEGADOS
extension ISMenuTableViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}



