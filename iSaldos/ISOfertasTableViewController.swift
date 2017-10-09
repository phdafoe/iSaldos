//
//  ISOfertasTableViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import APESuperHUD

class ISOfertasTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayOfertas : [ISOfertasModel] = []
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //LLAMADA A DATOS
        llamadaOfertas()
        
        
        //TODO: - Gestion del menu superior Izq.
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        //TODO: - Registro de celda
        tableView.register(UINib(nibName: "ISOfertaCustomCell", bundle: nil), forCellReuseIdentifier: "ISOfertaCustomCell")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfertas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customOfertasCell = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        let model = arrayOfertas[indexPath.row]
        
        customOfertasCell.myNombreOferta.text = model.nombre
        customOfertasCell.myFechaOferta.text = model.fechaFin
        customOfertasCell.myInformacionOferta.text = model.masInformacion
        customOfertasCell.myImporteOferta.text = model.importe
        
        customOfertasCell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath(CONSTANTES.LLAMADAS.OFERTAS,
                                                                                                               id: model.id,
                                                                                                               name: model.imagen))!),
                                                     placeholder: #imageLiteral(resourceName: "placeholder"),
                                                     options: nil,
                                                     progressBlock: nil,
                                                     completionHandler: nil)
        
        
        return customOfertasCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    func getImagePath(_ type: String, id : String!, name : String!) -> String{
        return CONSTANTES.LLAMADAS.BASE_PHOTO_URL + id + "/" + name
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showOfertaSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOfertaSegue"{
            let detalleVC = segue.destination as! ISDetalleOfertaViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayOfertas[selectInd!]
            detalleVC.oferta = objInd
            do{
                let imageData = UIImage(data: try Data(contentsOf: URL(string: CONSTANTES.LLAMADAS.BASE_PHOTO_URL + (objInd.id)! + "/" + (objInd.imagen)!)!))
                detalleVC.detalleImagenData = imageData!
            }catch let error{
                print("Error: \(error.localizedDescription)")
            }
            
            
        }
    }


   
    //MARK: - UTILS
    func llamadaOfertas(){
        let datosOfertas = ISParserOfertas()
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.OFERTAS
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        firstly{
            return when(resolved: datosOfertas.getDatosPromociones(idLocalidad,
                                                                   idTipo: tipoOferta,
                                                                   idParametro: tipoParametro))
            }.then{_ in
                self.arrayOfertas = datosOfertas.getParserPromociones()
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: { _ in
                    // Completed
                })
            }.catch{error in
                self.present(muestraAlertVC("Lo sentimos",
                                            messageData: "Algo salió mal"),
                             animated: true,
                             completion: nil)
        }
    }

}
