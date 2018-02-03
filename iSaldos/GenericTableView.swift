//
//  GenericTableView.swift
//  iEveris
//
//  Created by Andres on 31/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Kingfisher

public class ISALDOSellenarCeldas{
    
    
    /*func tipoGenericoMovies(_ customCell : GenericTableViewCell, arrayGenerico : GenericModelData, row : Int) -> GenericTableViewCell {
        
        customCell.myNombreOferta.text = arrayGenerico.title
        customCell.myFechaOferta.text = arrayGenerico.releaseDate
        customCell.myInformacionOferta.text = arrayGenerico.summary
        customCell.myImporteOferta.text = arrayGenerico.rentalPrice
        
        if let pathImagen = arrayGenerico.image {
            customCell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImagen)!),
                                                  placeholder: #imageLiteral(resourceName: "placeholder"),
                                                  options: [.transition(ImageTransition.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                    //guardamos las imágenes en un diccionario
                                                    guard let imageDataDes = imageData else {return}
                                                    diccionarioImagenes[arrayGenerico.id!] = imageDataDes
            })
        }
        return customCell
    }
    
    func tipoGenericoPerfil(_ customCell : MiPerfilCustomCell) -> MiPerfilCustomCell{
        customCell.myNombrePerfilUsuario.text = "Andres"
        customCell.myUsernameSportReviewLBL.text = "Ocampo"
        customCell.myFotoPerfilUsuario.image = #imageLiteral(resourceName: "steve_jobs")
        return customCell
    }*/
    
    func tipoGenericoCollectionCell(_ customCell : GenericCollectionViewCell, arrayGenerico : ISGenericModel, row : Int) -> GenericCollectionViewCell{
        
        customCell.myValueRent.text = arrayGenerico.name
        
        if let pathImagen = arrayGenerico.artworkUrl100 {
            customCell.myImagePoster.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImagen)!),
                                                  placeholder: #imageLiteral(resourceName: "placeholder"),
                                                  options: [.transition(ImageTransition.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                    //guardamos las imágenes en un diccionario
                                                    guard let imageDataDes = imageData else {return}
                                                    diccionarioImagenes[arrayGenerico.id!] = imageDataDes
            })
        }
        return customCell
        
    }
    
    
}

