//
//  ISDetallePersonasTableViewController.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 27/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import APESuperHUD

class ISDetallePersonasTableViewController: UITableViewController {
    
    //Variables
    var nombre = ""
    var detallePeople : ISResultDetailModel?
    var arrayPeopleModel : [Resultados] = []
    var arrayKnowfor : [KnownFor] = []
    let providerService = ISParserPeliculas()
    
    //IBOutlets
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.estimatedRowHeight = UITableViewAutomaticDimension
        myTableView.rowHeight = 60
        
        myTableView.register(UINib(nibName: "ISDetalleCabeceraPersonaCell", bundle: nil), forCellReuseIdentifier: "ISDetalleCabeceraPersonaCell")
        myTableView.register(UINib(nibName: "ISDetallePersonasCell", bundle: nil), forCellReuseIdentifier: "ISDetallePersonasCell")
        
        llamadaDetallePersonas(nombre)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func llamadaDetallePersonas(_ name : String){
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        providerService.getDataServiceDetailPeople(name, apiKey: CONSTANTES.API_KEY.API_KEY) { (resultDictionary, resultData, resultKnowfor) in
            guard let resultDictionaryDes = resultDictionary else {return}
            guard let resultDataDes = resultData else {return}
            guard let resultKnowforDes = resultKnowfor else {return}
            DispatchQueue.main.async {
                self.detallePeople = resultDictionaryDes
                self.arrayPeopleModel = resultDataDes
                self.arrayKnowfor = resultKnowforDes
                self.tableView.reloadData()
            }
            APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
        }
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrayPeopleModel.count
        }else{
            return arrayKnowfor.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ISDetalleCabeceraPersonaCell", for: indexPath) as! ISDetalleCabeceraPersonaCell
            let model = arrayPeopleModel[indexPath.row]
            cell.myNameProfile.text = model.name
                cell.myImageProfile.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+model.profilePath)!),
                                                     placeholder: #imageLiteral(resourceName: "placeholder"),
                                                     options: [.transition(ImageTransition.fade(1))],
                                                     progressBlock: nil,
                                                     completionHandler: nil)
            return cell
        }else{
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ISDetallePersonasCell", for: indexPath) as! ISDetallePersonasCell
            let modelData = arrayKnowfor[indexPath.row]
            cell.myImageBackgroound.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+modelData.backdropPath)!),
                                            placeholder: #imageLiteral(resourceName: "placeholder"),
                                            options: [.transition(ImageTransition.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            cell.myImageProfile.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+modelData.posterPath)!),
                                                placeholder: #imageLiteral(resourceName: "placeholder"),
                                                options: [.transition(ImageTransition.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            cell.myTitulo.text = modelData.title
            cell.myDescripcionLBL.text = modelData.overview
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 105
        }else /*if indexPath.section == 1*/{
            return UITableViewAutomaticDimension
        }
        //return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 105
        }else /*if indexPath.section == 1*/{
            return UITableViewAutomaticDimension
        }
        //return super.tableView(tableView, heightForRowAt: indexPath)
    }

    

}
