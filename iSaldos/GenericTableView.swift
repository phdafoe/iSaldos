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
    
    
    
    
    func tipoGenericoCollectionCell(_ customCell : GenericCollectionViewCell, arrayGenerico : PeliculasModel, row : Int) -> GenericCollectionViewCell{
        
        customCell.myValueRent.text = arrayGenerico.release_date
        
        if let pathImagen = arrayGenerico.poster_path {
            customCell.myImagePoster.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+pathImagen)!),
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
    
    func tipoGenericoCollectionCellTVShows(_ customCell : GenericCollectionViewCell, arrayGenerico : ISPopularTVModel, row : Int) -> GenericCollectionViewCell{
        
        customCell.myValueRent.text = arrayGenerico.originalName
        
        //if let pathImagen = arrayGenerico.posterPath {
            customCell.myImagePoster.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+arrayGenerico.posterPath)!),
                                                 placeholder: #imageLiteral(resourceName: "placeholder"),
                                                 options: [.transition(ImageTransition.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                    //guardamos las imágenes en un diccionario
                                                    guard let imageDataDes = imageData else {return}
                                                    diccionarioImagenes[arrayGenerico.id] = imageDataDes
            })
        //}
        return customCell
    }
    
    func tipoGenericoCollectionCellCast(_ customCell : GenericCollectionViewCell, arrayCast : ISCastPeliculaModel, row : Int) -> GenericCollectionViewCell{
        
        customCell.myValueRent.text = arrayCast.name
        customCell.myCharacter?.text = arrayCast.character
        
        //if let pathImagen = arrayCast.profilePath {
            customCell.myImagePoster.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+arrayCast.profilePath)!),
                                                 placeholder: #imageLiteral(resourceName: "placeholder"),
                                                 options: [.transition(ImageTransition.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                    //guardamos las imágenes en un diccionario
                                                    guard let imageDataDes = imageData else {return}
                                                    diccionarioImagenes[arrayCast.id] = imageDataDes
            })
        //}
        return customCell
    }
    
    func tipoGenericoCollectionCellSesion(_ customCell : GenericCollectionViewCell, arrayCast : Season, row : Int) -> GenericCollectionViewCell{
        
        customCell.myValueRent.text = arrayCast.name
        customCell.myCharacter?.text = arrayCast.airDate
        
        if let pathImagen = arrayCast.posterPath {
        customCell.myImagePoster.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath()+pathImagen)!),
                                             placeholder: #imageLiteral(resourceName: "placeholder"),
                                             options: [.transition(ImageTransition.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                //guardamos las imágenes en un diccionario
                                                guard let imageDataDes = imageData else {return}
                                                diccionarioImagenes[arrayCast.id] = imageDataDes
        })
        }
        return customCell
    }
    
    
}

