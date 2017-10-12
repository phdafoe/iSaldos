//
//  ISHomeViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISHomeViewController: UIViewController {
    
    //MARK: - Variables locales
    var items = NSArray()
    var customTabSwipeNavigation : CarbonTabSwipeNavigation!
    let botonFlotante = UIButton()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: - Gestion del menu superior Izq.
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        items = ["Mi Canal", "Mi Muro"]
        customTabSwipeNavigation = CarbonTabSwipeNavigation(items: (items as! [Any]), delegate: self)
        customTabSwipeNavigation.insert(intoRootViewController: self)
        style()
        
        self.navigationItem.title = "SOCIAL"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        botonFlotante.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 64.0, height: 64.0))
        botonFlotante.setImage(UIImage(named: "boton_Menu_MiPerfil"), for: UIControlState())
        botonFlotante.center = CGPoint(x: self.view.bounds.width - 42.0, y: self.view.bounds.height - 150.0)
        botonFlotante.addTarget(self, action: #selector(self.showVCNuevoComentario), for: .touchUpInside)
        self.view.addSubview(botonFlotante)
    }
    

    func style(){
        let customColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        customTabSwipeNavigation.toolbar.isTranslucent = false
        customTabSwipeNavigation.setIndicatorColor(customColor)
        customTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width / 2, forSegmentAt: 0)
        customTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width / 2, forSegmentAt: 1)
        customTabSwipeNavigation.setNormalColor(customColor.withAlphaComponent(0.6))
        customTabSwipeNavigation.setSelectedColor(customColor, font: UIFont.boldSystemFont(ofSize: 14))
    }
    
    func showVCNuevoComentario(){
        let nuevoPostVC = self.storyboard?.instantiateViewController(withIdentifier: "NuevoPostTableViewController") as! ISNuevoPostTableViewController
        let navController = UINavigationController(rootViewController: nuevoPostVC)
        self.present(navController, animated: true, completion: nil)
    }
    

    

}

extension ISHomeViewController : CarbonTabSwipeNavigationDelegate{
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            return self.storyboard?.instantiateViewController(withIdentifier: "CanalSocialViewController") as! ISCanalSocialViewController
        default:
            return self.storyboard?.instantiateViewController(withIdentifier: "MuroSocialViewController") as! ISMuroSocialViewController
        }
    }
    
}


