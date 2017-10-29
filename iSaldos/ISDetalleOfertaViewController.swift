//
//  ISDetalleOfertaViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import MapKit

class ISDetalleOfertaViewController: UITableViewController {
    
    //MARK: - Variables locales
    var oferta : ISOfertasModel?
    var detalleImagenData : UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myFechaOferta: UILabel!
    @IBOutlet weak var myInformacionOferta: UILabel!
    @IBOutlet weak var myNombreAsociado: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myMovilAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myTelefonoFijo: UIButton!
    @IBOutlet weak var myWebURL: UIButton!
    
    @IBAction func myLlamarFijoACTION(_ sender: UIButton) {
        //Recuperar el teléfono
        let telefono = sender.titleLabel?.text
        if let telefonoDes = telefono {
            llamar(telefonoDes)
        }
        
    }
    
    @IBAction func myCargarPaginaACTION(_ sender: UIButton) {
        if let web = sender.titleLabel?.text {
            muestraPaginaWebAsociado(web)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let ofertaDes = oferta, let AsociadoDes = oferta?.asociado{
        
        myImagenOferta.image = detalleImagenData
        myNombreOferta.text = ofertaDes.nombre
        myFechaOferta.text = ofertaDes.fechaFin
        myInformacionOferta.text = ofertaDes.masInformacion
        myNombreAsociado.text = AsociadoDes.nombre
        myDescripcionAsociado.text = AsociadoDes.descripcion
        myMovilAsociado.text = AsociadoDes.telefonoMovil
        myEmailAsociado.text = AsociadoDes.mail
        myWebURL.setTitle(AsociadoDes.web, for: .normal)
        myTelefonoFijo.setTitle(AsociadoDes.telefonoFijo, for: .normal)
            
        }
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(40.352494, -3.809620), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(40.352494, -3.809620)
        annotation.title = oferta?.nombre
        annotation.subtitle = oferta?.asociado?.direccion
        myMapView.addAnnotation(annotation)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Utils
    func getImagePath(_ type: String, id : String!, name : String!) -> String{
        return CONSTANTES.LLAMADAS.BASE_PHOTO_URL + id + "/" + name
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    ///Permite llamar a un número de teléfono
    func llamar(_ telefono : String){
        if let phoneCallURL = URL(string: "tel://\(telefono)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    ///Permite llamar a un número de teléfono
    func accederURL(_ web : String){
        if let webURL = URL(string: "\(web)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(webURL)) {
                application.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    ///Mostrar un viewcontroller con una web
    func muestraPaginaWebAsociado(_ url: String){
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "ISWebViewController") as! ISWebViewController
        webVC.urlWeb = url
        present(webVC, animated: true, completion: nil)
    }

    
    

}
