//
//  ISDetalleTVShowsTableViewController.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 26/8/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import APESuperHUD

class ISDetalleTVShowsTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var modelData : ISDetailTVShowsModel?
    var id = 0
    var arrayNetwork : [Network] = []
    var arraySeason : [Season] = []
    
    var customCellData : GenericCollectionViewCell?
    let providerService = ISParserPeliculas()
    var imageLogoEmpty = ""
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenMovie: UIImageView!
    @IBOutlet weak var myNombreProducto: UILabel!
    @IBOutlet weak var myFechaLanzamientoProducto: UILabel!
    @IBOutlet weak var myRate: UILabel!
    @IBOutlet weak var myInfoUrlProducto: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageLogo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //LLAMADA DATOS
        llamadaDetailTVShows()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func llamadaDetailTVShows(){
        APESuperHUD.show(style: HUDStyle.textOnly, title: nil, message: "Cargando..", completion: nil)
        let idMovie = "\(self.id)"
        providerService.getDataServiceDetailPopularTVShows(idMovie, apiKey: CONSTANTES.API_KEY.API_KEY) { (resultData, resultNetwork, resultSeason) in
            guard let resultDataDes = resultData else {return}
            guard let resultNetworkDes = resultNetwork else {return}
            guard let resultSeasonDes = resultSeason else {return}
            DispatchQueue.main.async {
                self.modelData = resultDataDes
                self.arraySeason = resultSeasonDes
                if let modelDataDes = self.modelData{
                    let imagenBack = modelDataDes.backdropPath
                    let uriImagenBack = getImagePath()+imagenBack
                    let imagePoster = modelDataDes.posterPath
                    let urlImagePoster = getImagePath()+imagePoster
                    if resultNetworkDes.count == 0{
                        self.imageLogoEmpty = ""
                    }else{
                        guard let logoPath = resultNetworkDes[0].logoPath else {return}
                        self.imageLogoEmpty = logoPath
                    }
                    let uriImageLogo = getImagePath()+self.imageLogoEmpty
                    self.imageBackground.kf.setImage(with: ImageResource(downloadURL: URL(string: uriImagenBack)!))
                    self.myImagenMovie.kf.setImage(with: ImageResource(downloadURL: URL(string: urlImagePoster)!))
                    self.imageLogo.kf.setImage(with: ImageResource(downloadURL: URL(string: uriImageLogo)!))
                    
                    self.myNombreProducto.text = modelDataDes.name
                    self.myFechaLanzamientoProducto.text = modelDataDes.lastAirDate
                    self.myInfoUrlProducto.text = modelDataDes.overview
                    self.myRate.text = "\(modelDataDes.voteAverage)"
                    self.title = modelDataDes.originalName
                    self.tableView.reloadData()
                    self.myCollectionView.reloadData()
                }
                APESuperHUD.dismissAll(animated: true)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ISDetalleTVShowsTableViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySeason.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modeldata = arraySeason[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! GenericCollectionViewCell
        let cell = ISALDOSellenarCeldas().tipoGenericoCollectionCellSesion(customCell,
                                                                         arrayCast: modeldata,
                                                                         row: indexPath.row)
        customCellData = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
