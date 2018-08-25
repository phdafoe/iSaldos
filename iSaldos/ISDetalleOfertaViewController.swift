//
//  ISDetalleOfertaViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import WebKit
import PromiseKit
import Kingfisher
import APESuperHUD

class ISDetalleOfertaViewController: UITableViewController {
    
    //MARK: - Variables locales
    var modelData : ISDetailPeliculaModel?
    var id = 0
    var arrayCast : [ISCastPeliculaModel] = []
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
        
        self.myImagenMovie.layer.borderWidth = 1
        self.myImagenMovie.layer.borderColor = UIColor.white.cgColor
        
        //LLAMADA A DATOS
        llamadaDetailMovie()
        
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
    
    //MARK: - UTILS
    func llamadaDetailMovie(){
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        let idMovie = "\(self.id)"
        providerService.getDataServiceDetailPeliculas(idMovie, apiKey: CONSTANTES.API_KEY.API_KEY) { (resultData, resultCompany) in
            guard let resultDataDes = resultData else {return}
            guard let resultCompanyDes = resultCompany else {return}
            DispatchQueue.main.async {
            self.modelData = resultDataDes
                if let modelDataDes = self.modelData{
                    let imagenBack = modelDataDes.backdropPath
                    let uriImagenBack = getImagePath()+imagenBack
                    let imagePoster = modelDataDes.posterPath
                    let urlImagePoster = getImagePath()+imagePoster
                    if resultCompanyDes.count == 0{
                        self.imageLogoEmpty = ""
                    }else{
                        self.imageLogoEmpty = resultCompanyDes[0].logoPath
                    }
                    let uriImageLogo = getImagePath()+self.imageLogoEmpty
                    self.imageBackground.kf.setImage(with: ImageResource(downloadURL: URL(string: uriImagenBack)!))
                    self.myImagenMovie.kf.setImage(with: ImageResource(downloadURL: URL(string: urlImagePoster)!))
                    self.imageLogo.kf.setImage(with: ImageResource(downloadURL: URL(string: uriImageLogo)!))
                    
                    self.myNombreProducto.text = modelDataDes.title
                    self.myFechaLanzamientoProducto.text = modelDataDes.releaseDate
                    self.myInfoUrlProducto.text = modelDataDes.overview
                    self.myRate.text = "\(modelDataDes.voteAverage)"
                    self.title = modelDataDes.originalTitle
                    self.tableView.reloadData()
                }
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
                self.llamadaMovies()
            }
        }
    }
    
    func llamadaMovies(){
        let idMovie = "\(self.id)"
        providerService.getDataServiceCast(idMovie, apiKey: CONSTANTES.API_KEY.API_KEY) { (resultData) in
            guard let resultDataDes = resultData else { return }
            DispatchQueue.main.async {
                self.arrayCast = resultDataDes
                self.myCollectionView.reloadData()
            }
        }
    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ISDetalleOfertaViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modeldata = arrayCast[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! GenericCollectionViewCell
        let cell = ISALDOSellenarCeldas().tipoGenericoCollectionCellCast(customCell,
                                                                         arrayCast: modeldata,
                                                                         row: indexPath.row)
        customCellData = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let webVC = self.storyboard?.instantiateViewController(withIdentifier: ISWebViewController.defaultNibVC) as! ISWebViewController
//        let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row
//        let objInd = arrayGeneric[selectInd!]
//        webVC.urlWeb = objInd.url
//        present(webVC, animated: true, completion: nil)
    }
    
    
}

