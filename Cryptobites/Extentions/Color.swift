//
//  Color.swift
//  Cryptobites
//
//  Created by VENOM on 3/23/23.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
}
