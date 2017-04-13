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
    @IBOutlet weak var myFijoAsociado: UILabel!
    @IBOutlet weak var myMovilAsociado: UILabel!
    @IBOutlet weak var myWebAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myMapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagenOferta.image = detalleImagenData
        myNombreOferta.text = oferta?.nombre
        myFechaOferta.text = oferta?.fechaFin
        myInformacionOferta.text = oferta?.masInformacion
        myNombreAsociado.text = oferta?.asociado?.nombre
        myDescripcionAsociado.text = oferta?.asociado?.descripcion
        myFijoAsociado.text = oferta?.asociado?.telefonoFijo
        myMovilAsociado.text = oferta?.asociado?.telefonoMovil
        myWebAsociado.text = oferta?.asociado?.web
        myEmailAsociado.text = oferta?.asociado?.mail
        
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

    
    

}
