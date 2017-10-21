//
//  ISGaleriaTutorialViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISGaleriaTutorialViewController: UIViewController {
 
    //MARK: - IBOutlets
    @IBOutlet weak var myScrollShowGallery: UIScrollView!
    @IBOutlet weak var myPageShowGallery: UIPageControl!
    @IBOutlet weak var myOmitirBTN: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //let anchoImagen = self.view.frame.size.width
        let anchoImagen = self.view.bounds.size.width
        let altoImagen = self.view.bounds.size.height
        
        for c_imagen in 0..<8{
            let imagenes = UIImageView(image: UIImage(named: String(format: "FOTO_%d.jpg", c_imagen)))
            imagenes.frame = CGRect(x: CGFloat(c_imagen) * anchoImagen,
                                    y: 0,
                                    width: anchoImagen,
                                    height: altoImagen)
            
            myScrollShowGallery.addSubview(imagenes)
            myOmitirBTN.isHidden = false
        }
        
        myScrollShowGallery.delegate = self
        myScrollShowGallery.contentSize = CGSize(width: 7 * anchoImagen, height: altoImagen)
        myScrollShowGallery.isPagingEnabled = true
        myPageShowGallery.numberOfPages = 7
        myPageShowGallery.currentPage = 0
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ISGaleriaTutorialViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = myScrollShowGallery.contentOffset.x / myScrollShowGallery.frame.size.width
        myPageShowGallery.currentPage = Int(page)
    }
    
}
