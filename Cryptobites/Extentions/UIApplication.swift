//
//  UIApplication.swift
//  Cryptobites
//
//  Created by VENOM on 3/25/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
 
