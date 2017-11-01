//
//  ISSplashViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISSplashViewController: UIViewController {
    
    
    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageLogoSaldos: UIImageView!
    @IBOutlet weak var myComprobacionInternet: UIImageView!
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(!isInternetAvailable()){
            UIView.animate(withDuration: 3,
                           animations: {
                            self.myComprobacionInternet.isHidden = false
            })
        }else{
            self.showData()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func showData(){
        viewAnimator = UIViewPropertyAnimator(duration: 1.0,
                                              curve: .easeInOut,
                                              animations: {
                                                self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 1.5,
                                                                                            target: self,
                                                                                            selector: #selector(self.manejadorAutomatico),
                                                                                            userInfo: nil,
                                                                                            repeats: false)
        })
        
        viewAnimator.startAnimation()
    }
    
    
    //MARK: - Utils
    @objc func manejadorAutomatico(){
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
        //if(customPrefs.string(forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL) != nil){
            if PFUser.current() == nil{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! ISLoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
            }else{
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)
            }
       // }
//        }else{
//            customPrefs.setValue("ok", forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL)
//            let galeriaVC = self.storyboard?.instantiateViewController(withIdentifier: "ISGaleriaCollectionViewController") as! ISGaleriaCollectionViewController
//            galeriaVC.modalTransitionStyle = .crossDissolve
//            present(galeriaVC,
//                    animated: true,
//                    completion: nil)
//        }
    }

}
