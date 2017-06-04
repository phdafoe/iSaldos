//
//  ISSplashViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import ReachabilitySwift

class ISSplashViewController: UIViewController {
    
    
    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    var customReac = Reachability()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageLogoSaldos: UIImageView!
    @IBOutlet weak var myImagenProblemasConexion: UIImageView!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: customReac)
        do{
            try customReac?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            //empezar()
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                self.showAnimation()
            } else {
                print("Reachable via Cellular")
                self.showAnimation()
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.myImagenProblemasConexion.isHidden = false
            })
            print("Network not reachable")
        }
    }
    
    func showAnimation(){
        viewAnimator = UIViewPropertyAnimator(duration: 1.0,
                                              curve: .easeInOut,
                                              animations: {
                                                self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                
        })
        
        viewAnimator.startAnimation()
        viewAnimator.addCompletion { _ in
            self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 1.5,
                                                        target: self,
                                                        selector: #selector(self.manejadorAutomatico),
                                                        userInfo: nil,
                                                        repeats: false)
        }
    }
    
    //MARK: - Utils
    func manejadorAutomatico(){
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut) {
                                                    self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 25,
                                                                                                         y: 25)
        }
        logoAnimacion.startAnimation()
        logoAnimacion.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp(){
        if(customPrefs.string(forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL) != nil){
            if PFUser.current() == nil{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! ISLoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
                limpiar()
            }else{
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)
                limpiar()
            }
        }else{
            customPrefs.setValue("ok", forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL)
            let galeriaVC = self.storyboard?.instantiateViewController(withIdentifier: "GaleriaTutorialViewController") as! ISGaleriaTutorialViewController
            galeriaVC.modalTransitionStyle = .crossDissolve
            present(galeriaVC,
                    animated: true,
                    completion: nil)
            limpiar()
        }
    }
    
    
    func limpiar(){
        customReac?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: customReac)
    }

}
