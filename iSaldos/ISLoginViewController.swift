//
//  ISLoginViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class ISLoginViewController: UIViewController {
    
    //MARK: - Varibales locales
    var player: AVPlayer!
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myActiINd: UIActivityIndicatorView!
    @IBOutlet weak var myAccederBTN: UIButton!
    @IBOutlet weak var myRegistrarseBTN: UIButton!
    
    
    
    @IBAction func accessApp(_ sender: Any) {
        
        let sigIn = APISignIn(pUsername: myUsernameTF.text!,
                              pPassword: myPasswordTF.text!)
        
        do{
            try sigIn.signInUser()
            self.performSegue(withIdentifier: "jumpToViewContollerFromLogin", sender: self)
        }catch let error{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }catch{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "Algo salio mal"),
                    animated: true,
                    completion: nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showVideo()
        
        
        myActiINd.isHidden = true
        
        myAccederBTN.layer.cornerRadius = 5
        myRegistrarseBTN.layer.cornerRadius = 5
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }
    }

    //TODO: - LOGOUT
    @IBAction func heHechoLogout(segue: UIStoryboardSegue){
        print("cierre de sesion exitoso")
    }
    
    //TODO: - SHOWVIDEO
    func showVideo(){
        
        //VIDEO
        let path = Bundle.main.path(forResource: "Nike_iOS", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.none;
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: kCMTimeZero)
        player!.play()
    }

    func playerItemDidReachEnd() {
        player.seek(to: kCMTimeZero)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
