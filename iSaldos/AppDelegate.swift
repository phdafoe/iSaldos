//
//  AppDelegate.swift
//  iSaldos
//
//  Created by Andres on 13/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

var enlace = ""
var abroWeb = false



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse.
        let configuration = ParseClientConfiguration {
            $0.applicationId = "VKMdpH0OweBcfhcPJ0q12U2APc9vx8gcS8wMocCv"
            $0.clientKey = "mIJ12lUNZ2NllWXswJZjdmfhVbtYrF09XWvwTMrE"
            $0.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)
        
        personalizaUI()
        
        //TODO: --//REGISTRO DE NOTIFICACIONES
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (exitoso, error) in
            if exitoso{
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        
        return true
        
    }
    
    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func personalizaUI(){
        let navBar = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        let toolBar = UIToolbar.appearance()
        
        
        
        navBar.barTintColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        tabBar.barTintColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        
        toolBar.barTintColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        toolBar.tintColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        
        navBar.tintColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        tabBar.tintColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : CONSTANTES.COLORES.BLANCO_TEXTO_NAV]
    }
    
    /*func application(_ application: UIApplication, didRegisterForRemoteNOtificationsWithDeviceToken deviceToken: Data) {
        
        let installation = PFInstallation.current()
        //installation.setDeviceTokenFom(deviceToken)
        //installation.saveInBackground()
        //PFPush.subscribeToChannel(inBackground: “globalChannel”)
    }*/
    
    //--------------------------------------
    // MARK: Push Notifications  AQUI HA FALLADO EL REGISTRO
    //--------------------------------------
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        getAlert(notificacion: userInfo as! [String : Any])
        PFPush.handle(userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        
        print(notification.request.content.categoryIdentifier)
        completionHandler([.alert, .sound])
        print("recibo notificacion dentro")
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        
        //UIApplication.shared.applicationIconBadgeNumber += 1
        print("abro desde notificacion en response")
        completionHandler()
        getAlert(notificacion: response.notification.request.content.userInfo as! [String : AnyObject])
    }
    
    
    func notificationReceived(notification: [NSObject:AnyObject]) {
        getAlert(notificacion: notification as! [String : Any])
        
    }
    
    func getAlert(notificacion: [String : Any]){
        print("keys")
        print(notificacion.keys)
        let aps = notificacion["aps"]!
        //enlace = (aps["enlace"]!)! as! String
        enlace = ((aps as AnyObject) as? NSDictionary)?["enlace"] as! String
        print("enlace: \(enlace)")
        
        
        if tabBarRoot != nil{
            tabBarRoot?.abroWebNotificacion()
        }else{
            abroWeb = true
        }
        
    }
    
    
    

}

