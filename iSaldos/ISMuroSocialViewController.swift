//
//  ISMuroSocialViewController.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISMuroSocialViewController: UIViewController {
    
    var usersFromParse = [UserModel]()
    var usersFollowing = [Bool]()
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.estimatedRowHeight = 60
        myTableView.rowHeight = UITableViewAutomaticDimension
        
        myTableView.register(UINib(nibName: "ISNoPostCusotmCell", bundle: nil), forCellReuseIdentifier: "ISNoPostCusotmCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension ISMuroSocialViewController : UITableViewDelegate, UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if usersFromParse.count == 0{
            return 1
        }else{
            return 30
        }
        
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ISNoPostCusotmCell",
                                                       for: indexPath) as! ISNoPostCusotmCell
            
            return cell
        default:
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell",
                                                       for: indexPath) as! ISPostCustomCell
            
            return cell
        }
        
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 454
        default:
             return UITableViewAutomaticDimension
        }
    }
    
    
    
}
