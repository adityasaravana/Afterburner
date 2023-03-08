//
//  User.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation
import Valet

struct DataManager {
    let valet = Valet.valet(withExplicitlySet: Identifier(nonEmpty: "Afterburner")!, accessibility: .whenUnlockedThisDeviceOnly)
    
    func writeValue(_ string: String, key: String) {
        try? valet.setString(string, forKey: key)
    }
    
    func readValue(_ key: String) -> String? {
        try? valet.string(forKey: key)
    }
}
