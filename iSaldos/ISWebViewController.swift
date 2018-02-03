//
//  ISWebViewController.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import WebKit

class ISWebViewController: UIViewController, NibVC {    

    //MARK: - Variables Locales
    var urlWeb : String?
    
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: WKWebView!
    
    
    @IBAction func myCerrarVentanaACTION(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Mostrar activity inicialmente
        myActivityIndicator.isHidden = false
        
        //Crear delegados para la web
        myWebView.navigationDelegate = self
        
        //Cargar datos de la página
        let url = URL(string: urlWeb!)
        let peticion = URLRequest(url: url!)
        myWebView.load(peticion)
    }

}

extension ISWebViewController : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
    }
}
