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
    //var cupon : ISOfertasModel?
    var detalleImagenData : UIImage?
    
    //MARK: - VARIABLES QR
    var qrData : String?
    var codeBarData : String?
    var qrcodeImage : CIImage!
    var imageGroupTag = 3
    var customBackground : UIView!
    
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
        customBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBackground.backgroundColor = UIColor.black
        customBackground.alpha = 0.0
        customBackground.tag = imageGroupTag
        
        let custBack = UIViewPropertyAnimator(duration: 0.3,
                                              curve: .easeInOut) { 
                                                self.customBackground.alpha = 0.8
                                                self.view.addSubview(self.customBackground)
                                                
        }
        custBack.startAnimation()
        custBack.addCompletion({ _ in
            self.muestraImagen()
        })
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionGesture(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func shareSocialNetworkACTION(_ sender: Any) {
        /*customBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBackground.backgroundColor = UIColor.black
        customBackground.alpha = 0.0
        customBackground.tag = imageGroupTag
        
        let custBack = UIViewPropertyAnimator(duration: 0.3,
                                              curve: .easeInOut) {
                                                self.customBackground.alpha = 0.8
                                                self.view.addSubview(self.customBackground)
                                                
        }
        custBack.startAnimation()
        custBack.addCompletion { _ in*/
            self.muestraStoryboard()
        //}
    }
    
    
    
    //MARK: - GESTURE RECOGNIZER
    @objc func actionGesture(_ gestureRecognizer: UITapGestureRecognizer){
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
    
    func muestraImagen(){
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
            self.present(muestraAlertVC("Oops!",
                                        messageData: "Tenemos problemas para mostrar el Qr"),
                         animated: true,
                         completion: nil)
        }
    }
    
    func muestraStoryboard(){
        let sbData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let detalleUno = sbData.instantiateInitialViewController()!
        detalleUno.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.show(detalleUno as! UINavigationController, sender: self)
    }
    
        
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        /*myImagenOferta.image = detalleImagenData
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
        
        qrData = cupon?.asociado?.idActividad*/

        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    

}


