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
    var modelData : ISGenericModel?
    var detalleImagenData : UIImage?
    var arrayGeneric : [ISGenericModel] = []
    var customCellData : GenericCollectionViewCell?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreProducto: UILabel!
    @IBOutlet weak var myFechaLanzamientoProducto: UILabel!
    @IBOutlet weak var myWebViewProducto: WKWebView!
    @IBOutlet weak var myInfoUrlProducto: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myActiIndi: UIActivityIndicatorView!
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LLAMADA A DATOS
        llamadaMovies()
        
        guard let modelDataDes = modelData else { return }
        
        myImagenOferta.image = detalleImagenData
        imageBackground.image = detalleImagenData
        myNombreProducto.text = modelDataDes.name
        myFechaLanzamientoProducto.text = modelDataDes.releaseDate
        myInfoUrlProducto.text = modelDataDes.genres?[0].url
        
        let url = URL(string: modelDataDes.url!)
        let urlRequest = URLRequest(url: url!)
        myWebViewProducto.load(urlRequest)
        myWebViewProducto.navigationDelegate = self
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
    }

    //MARK: - UTILS
    func llamadaMovies(){
        
        let providerService = ISMoviesApple()
        
        let movies = CONSTANTES.LLAMADAS.APPLE_MUSIC
        let topMovies = CONSTANTES.LLAMADAS.HOT_TRACK_APPLE
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        firstly{
            return when(resolved: providerService.getDataServiceGeneric(movies, topMovies: topMovies, numberMovies: randonNumber()))
            }.then{_ in
                providerService.getParseGeneric(completion: { (resultData) in
                    self.arrayGeneric = resultData
                    self.myCollectionView.reloadData()
                    APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
                })
            }.catch{error in
                self.present(muestraAlertVC("Lo sentimos",
                                            messageData: "Algo salió mal"),
                             animated: true,
                             completion: nil)
        }
    }
    
}

extension ISDetalleOfertaViewController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActiIndi.isHidden = false
        myActiIndi.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActiIndi.isHidden = true
        myActiIndi.stopAnimating()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ISDetalleOfertaViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGeneric.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modeldata = arrayGeneric[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! GenericCollectionViewCell
        let cell = ISALDOSellenarCeldas().tipoGenericoCollectionCell(customCell,
                                                                     arrayGenerico: modeldata,
                                                                     row: indexPath.row)
        customCellData = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: ISWebViewController.defaultNibVC) as! ISWebViewController
        let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row
        let objInd = arrayGeneric[selectInd!]
        webVC.urlWeb = objInd.url
        present(webVC, animated: true, completion: nil)
    }
    
    
}
