//
//  BooksViewController.swift
//  iSaldos
//
//  Created by Andres on 3/2/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import APESuperHUD

class BooksViewController: UIViewController {

    //MARK: - Variables locales
    var refresh : UIRefreshControl?
    var arrayTVshows : [ISPopularTVModel] = []
    var customCellData : GenericCollectionViewCell?
    let providerService = ISParserPeliculas()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TV - Shows"
        
        //LLAMADA A DATOS
        llamadaTVShows()
        
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
    func llamadaTVShows(){
        
        APESuperHUD.show(style: HUDStyle.textOnly, title: nil, message: "Cargando..", completion: nil)
        providerService.getDataServicePopularTV(CONSTANTES.API_KEY.API_KEY) { (resultData) in
            guard let resultDataDes = resultData else { return }
            self.arrayTVshows = resultDataDes
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
                APESuperHUD.dismissAll(animated: true)
            }
        }
    }
    
    @objc func refreshControll(){
        myCollectionView!.reloadData()
        self.refresh?.endRefreshing()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailViewFromTVShows"{
            let detailVC = segue.destination as! ISDetalleTVShowsTableViewController
            let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row
            let objInd = arrayTVshows[selectInd!].id
            detailVC.id = objInd
            //detailVC.detalleImagenData = diccionarioImagenes[objInd.id!]!
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension BooksViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTVshows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modeldata = arrayTVshows[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! GenericCollectionViewCell
        let cell = ISALDOSellenarCeldas().tipoGenericoCollectionCellTVShows(customCell,
                                                                     arrayGenerico: modeldata,
                                                                     row: indexPath.row)
        customCellData = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailViewFromTVShows", sender: self)
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
