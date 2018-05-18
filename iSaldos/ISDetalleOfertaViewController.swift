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
    var modelData : PeliculasModel?
    var detalleImagenData : UIImage?
    var arrayGeneric : [PeliculasModel] = []
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
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        guard let modelDataDes = modelData else { return }
        
        let imagenBack = modelDataDes.backdrop_path
        let uriImagenBack = getImagePath()+imagenBack!
        
        myImagenOferta.image = detalleImagenData
        imageBackground.kf.setImage(with: ImageResource(downloadURL: URL(string: uriImagenBack)!))
        myNombreProducto.text = modelDataDes.title
        myFechaLanzamientoProducto.text = modelDataDes.release_date
        myInfoUrlProducto.text = "\(String(describing: modelDataDes.overview))"
        self.title = modelDataDes.original_title
        
        let url = URL(string: "http://www.andresocampo.com")
        let urlRequest = URLRequest(url: url!)
        myWebViewProducto.load(urlRequest)
        myWebViewProducto.navigationDelegate = self
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 2{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

    //MARK: - UTILS
    func llamadaMovies(){
        let providerService = ISParserPeliculas()
        let currentPage = 1
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        providerService.getDataServicePeliculas(CONSTANTES.API_KEY.API_KEY, numberPage: currentPage) { (resultData) in
            guard let resultDataDes = resultData else { return }
            self.arrayGeneric = resultDataDes
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            }
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
//        let webVC = self.storyboard?.instantiateViewController(withIdentifier: ISWebViewController.defaultNibVC) as! ISWebViewController
//        let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row
//        let objInd = arrayGeneric[selectInd!]
//        webVC.urlWeb = objInd.url
//        present(webVC, animated: true, completion: nil)
    }
    
    
}
