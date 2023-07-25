//
//  Defaults.swift
//  Afterburner
//
//  Created by Aditya Saravana on 7/24/23.
//

import Foundation
import Defaults


extension Defaults.Keys {
//    static let quality = Key<Double>("quality", default: 0.8)
    //            ^            ^         ^                ^
    //           Key          Type   UserDefaults name   Default value
    static let maxTokens = Key<Int>("maxTokens", default: 1440)
    static let onboard = Key<Bool>("onboard", default: true)
    
}
