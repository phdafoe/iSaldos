//
//  RateApp.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//



import UIKit

// ----APP RATE SETTINGS ---
let APP_ID = "981848691"

let showRateTimes = 3 //Times rateApp() called before alert shows
// -------------------------

let RATED_DEFAULT_KEY = "RATED_APP_KEY"
let RATE_CNT_KEY = "RATE_CNT_KEY"

var defaults: UserDefaults!
var viewLoaded: Int = 0

func showRateAlertInmediatly (_ view: UIViewController) {
    rateApp(view, immediatly: true)
}

func rateApp(_ view: UIViewController, immediatly: Bool?) {
    if  defaults == nil {
        defaults = UserDefaults()
        viewLoaded = defaults.object(forKey: RATE_CNT_KEY) == nil ? 0 : defaults.object(forKey: RATE_CNT_KEY) as! Int
    }
    
    var immed = false
    
    if immediatly != nil {
        immed = immediatly!
    }
    
    if !immed {
        viewLoaded += 1
    }
    
    defaults.set(viewLoaded, forKey: "viewLoadedCntRateApp")
    
    if viewLoaded % showRateTimes == 0 || immed {
        if (defaults.object(forKey: RATED_DEFAULT_KEY) == nil || immed) {
            viewLoaded = 0
            
            let rateAlert = UIAlertController(title: "¡Por favor, califícanos!", message: "¿Cuánto te ha gustado la App?", preferredStyle: .alert)
            
            let fiveStarsAction = UIAlertAction(title: "★★★★★", style: .default, handler: {(alert: UIAlertAction!) in goToRate(view)})
            rateAlert.addAction(fiveStarsAction)
            let fourStarsAction = UIAlertAction(title: "★★★★✩", style: .default, handler: {(alert: UIAlertAction!) in goToRate(view)})
            rateAlert.addAction(fourStarsAction)
            let threeStarsAction = UIAlertAction(title: "★★★✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Gracias", message: "Apreciamos tu opinón.")
                noMoreRate()
            })
            rateAlert.addAction(threeStarsAction)
            let twoStarsAction = UIAlertAction(title: "★★✩✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Gracias", message: "Apreciamos tu opinón.")
                noMoreRate()
            })
            rateAlert.addAction(twoStarsAction)
            let oneStarsAction = UIAlertAction(title: "★✩✩✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Gracias", message: "Apreciamos tu opinón.")
                noMoreRate()
            })
            rateAlert.addAction(oneStarsAction)
            let notNowAction = UIAlertAction(title: "Ahora no", style: .default, handler: nil)
            rateAlert.addAction(notNowAction)
            let noThanksAction = UIAlertAction(title: "Quizá en otro momento", style: .default, handler: {(alert: UIAlertAction!) in noMoreRate()})
            rateAlert.addAction(noThanksAction)
            
            view.present(rateAlert, animated: true, completion: nil)
        }
    }
}

func goToRate(_ view: UIViewController) {
    //"Now, App Store will open and you just have to write a review in 'Reviews' tabs."
    let openStoreAlert = UIAlertController(title: "¡Genial!", message: "Ahora se abrirá el App Store para que escribas una reseña en la pestaña de 'Reseñas'", preferredStyle: .alert)
    //"Go To App Store"
    let openStoreAction = UIAlertAction(title: "Ir al App Store", style: .default, handler: {(slert: UIAlertAction) in
        noMoreRate()
        UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/app/id\(APP_ID)")!,
                                  options: [:],
                                  completionHandler: nil)
    })
    
    openStoreAlert.addAction(openStoreAction)
    
    view.present(openStoreAlert, animated: true, completion: nil)
}

func noMoreRate () {
    let defaults = UserDefaults()
    
    defaults.set(true, forKey: RATED_DEFAULT_KEY)
}

func getRateAlertCountdown() -> Int {
    defaults = UserDefaults()
    if defaults.object(forKey: RATED_DEFAULT_KEY) == nil {
        return showRateTimes - viewLoaded
    }
    else {
        return 0
    }
}

func showCloseAlert (_ view: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
    alert.addAction(alertAction)
    
    view.present(alert, animated: true, completion: nil)
}
