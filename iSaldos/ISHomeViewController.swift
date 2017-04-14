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
        
        
        items = ["Muro", "Canal"]
        customTabSwipeNavigation = CarbonTabSwipeNavigation(items: (items as! [Any]), delegate: self)
        customTabSwipeNavigation.insert(intoRootViewController: self)
        style()
        
        self.navigationItem.title = "SOCIAL"
        
        // Do any additional setup after loading the view.
    }

    func style(){
        let customColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customTabSwipeNavigation.toolbar.isTranslucent = false
        customTabSwipeNavigation.setIndicatorColor(customColor)
        customTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width / 2, forSegmentAt: 0)
        customTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width / 2, forSegmentAt: 1)
        customTabSwipeNavigation.setNormalColor(customColor.withAlphaComponent(0.6))
        customTabSwipeNavigation.setSelectedColor(customColor, font: UIFont.boldSystemFont(ofSize: 14))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ISHomeViewController : CarbonTabSwipeNavigationDelegate{
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            return self.storyboard?.instantiateViewController(withIdentifier: "MuroSocialViewController") as! ISMuroSocialViewController
        default:
            return self.storyboard?.instantiateViewController(withIdentifier: "CanalSocialViewController") as! ISCanalSocialViewController
        }
    }
    
}


