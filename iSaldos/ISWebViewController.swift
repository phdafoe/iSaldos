//
//  ISWebViewController.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISWebViewController: UIViewController {

    //MARK: - Variables Locales
    var urlWeb : String?
    
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: UIWebView!
    
    
    @IBAction func myCerrarVentanaACTION(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Mostrar activity inicialmente
        myActivityIndicator.isHidden = false
        
        //Crear delegados para la web
        myWebView.delegate = self
        
        //Cargar datos de la página
        let url = URL(string: "http://" + urlWeb!)
        let peticion = URLRequest(url: url!)
        myWebView.loadRequest(peticion)
    }

}

extension ISWebViewController : UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
    }
}
