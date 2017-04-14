//
//  ISDetalleCuponesViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISDetalleCuponesViewController: UITableViewController {

    //MARK: - Variables locales
    var cupon : ISOfertasModel?
    var detalleImagenData : UIImage?
    
    //MARK: - VARIABLES QR
    var qrData : String?
    var codeBarData : String?
    var qrcodeImage : CIImage!
    var imageGroupTag = 3
    
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
    @IBOutlet weak var myIdActividad: UILabel!
    
    
    @IBAction func qrACTION(_ sender: Any) {
        let customBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBackground.backgroundColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customBackground.alpha = 0.5
        customBackground.tag = imageGroupTag
        self.view.addSubview(customBackground)
        
        if myIdActividad.text == qrData{
            let anchoImagen = self.view.frame.width / 1.5
            let altoImagen = self.view.frame.height / 3
            let imageView = UIImageView(frame: CGRect(x: (self.view.frame.width / 2 - anchoImagen / 2),
                                                      y: (self.view.frame.height / 2 - altoImagen / 2),
                                                      width: anchoImagen,
                                                      height: altoImagen))
            imageView.contentMode = .scaleAspectFit
            imageView.tag = imageGroupTag
            imageView.image = fromString(qrData!)
            self.view.addSubview(imageView)
        }else{
            present(muestraAlertVC("Oops!",
                                   messageData: "Tenemos problemas para mostrar el Qr"),
                    animated: true,
                    completion: nil)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionGesture(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func shareSocialNetworkACTION(_ sender: Any) {
        let image = detalleImagenData
        let texto = cupon?.asociado?.descripcion
        let web = cupon?.asociado?.web
        let shared = UIActivityViewController(activityItems: [image!, texto!, web!], applicationActivities: nil)
        present(shared,
                animated: true,
                completion: nil)
    }
    
    
    
    //MARK: - GESTURE RECOGNIZER
    func actionGesture(_ gestureRecognizer: UITapGestureRecognizer){
        for subview in self.view.subviews{
            if subview.tag == self.imageGroupTag{
                subview.removeFromSuperview()
            }
        }
    }
    
    func fromString(_ string : String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: filter!.outputImage!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagenOferta.image = detalleImagenData
        myNombreOferta.text = cupon?.nombre
        myFechaOferta.text = cupon?.fechaFin
        myInformacionOferta.text = cupon?.masInformacion
        myNombreAsociado.text = cupon?.asociado?.nombre
        myDescripcionAsociado.text = cupon?.asociado?.descripcion
        myFijoAsociado.text = cupon?.asociado?.telefonoFijo
        myMovilAsociado.text = cupon?.asociado?.telefonoMovil
        myWebAsociado.text = cupon?.asociado?.web
        myEmailAsociado.text = cupon?.asociado?.mail
        myIdActividad.text = cupon?.asociado?.idActividad
        
        qrData = cupon?.asociado?.idActividad

        
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
