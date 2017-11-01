//
//  HayInternet.swift
//  MyLog
//
//  Created by Sergio Gutiérrez Marfil on 8/10/17.
//  Copyright © 2017 Sergio Gutiérrez Marfil. All rights reserved.
//
import Foundation
import SystemConfiguration

func isInternetAvailable() -> Bool
{
    //PARA COMPROBAR SI HAY CONEXiÓN (https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10)
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}
