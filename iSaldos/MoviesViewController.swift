//
//  MoviesViewController.swift
//  iSaldos
//
//  Created by Andres on 3/2/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import APESuperHUD

class MoviesViewController: UIViewController {
    
    //MARK: - Variables locales
    var refresh : UIRefreshControl?
    var arrayGeneric : [ISGenericModel] = []
    var customCellData : GenericCollectionViewCell?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        //LLAMADA A DATOS
        llamadaMovies()

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Pull to recharge")
        refresh?.addTarget(self, action: #selector(self.refreshControll), for: .valueChanged)
        myCollectionView!.addSubview(refresh!)
        
        //TODO: - Gestion del menu superior Izq.
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UTILS
    func llamadaMovies(){
        
        let providerService = ISMoviesApple()
        
        let movies = CONSTANTES.LLAMADAS.MOVIES_APPLE
        let topMovies = CONSTANTES.LLAMADAS.TOP_MOVIE_APPLE
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        firstly{
            return when(resolved: providerService.getDataServiceGeneric(movies, topMovies: topMovies, numberMovies: randonNumber()))
            }.then{_ in
                providerService.getParseGeneric(completion: { (resultData) in
                    self.arrayGeneric = resultData
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                    }
                })
            }.then{_ in
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            }.catch{error in
                self.present(muestraAlertVC("Lo sentimos",
                                            messageData: "Algo salió mal"),
                             animated: true,
                             completion: nil)
        }
    }
    
    @objc func refreshControll(){
        llamadaMovies()
        myCollectionView!.reloadData()
        self.refresh?.endRefreshing()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailView"{
            let detailVC = segue.destination as! ISDetalleOfertaViewController
            let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row
            let objInd = arrayGeneric[selectInd!]
            detailVC.modelData = objInd
            detailVC.detalleImagenData = diccionarioImagenes[objInd.id!]!
        }
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        imagenSeleccionada = customCellData?.myImagePoster.image
        performSegue(withIdentifier: "showDetailView", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing = CGFloat(1) //Define the space between each cell
        let leftRightMargin = CGFloat(20) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(2) //The total number of columns you want
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - leftRightMargin - totalCellSpace) / numColumns
        var height = CGFloat(270) //whatever height you want
        height = width * height / 180
        return CGSize(width: width, height: height)
    }
    
    
}
