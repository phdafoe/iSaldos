//
//  ISWebViewController.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 4/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISWebViewController: UIViewController {
    
    var detalleWebPublicidad : String?
    var detalleTitulo : String?
    
    
    @IBOutlet weak var myWebView: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customUrl = URL(string:detalleWebPublicidad!)
        let customRequest = URLRequest(url: customUrl!)
        myWebView.loadRequest(customRequest)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
