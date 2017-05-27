//
//  ISActionSheetPersonalizadoViewController.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 23/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit



class ISActionSheetPersonalizadoViewController: UIViewController {
    
    var arrayRedesSociales = ["Facebook", "Twitter"]
    var arrayImagenesRedesSociales = ["like", "nation"]
    
    
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mycancelarBTN: UIButton!
    
    
    
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        myCustomView.layer.cornerRadius = 10
        mycancelarBTN.layer.cornerRadius = 10
        
        
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ISActionSheetPersonalizadoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRedesSociales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let modelNombres = arrayRedesSociales[indexPath.row]
        let modelImagenes = arrayImagenesRedesSociales[indexPath.row]
        
        cell.textLabel?.text = modelNombres
        cell.detailTextLabel?.text = "\(Date())"
        cell.imageView?.image = UIImage(named: modelImagenes)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


