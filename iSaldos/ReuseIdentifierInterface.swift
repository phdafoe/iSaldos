//
//  ReuseIdentifierInterface.swift
//  iSaldos
//
//  Created by Andres on 3/2/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import UIKit

public protocol ReuseIdentifierInterface : class{
    static var defaultReuseIdentifier : String { get }
}

public protocol NibVC : class{
    static var defaultNibVC : String { get }
}

public extension NibVC where Self : UIViewController{
    static var defaultNibVC : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

public extension ReuseIdentifierInterface where Self : UIView{
    static var defaultReuseIdentifier : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
