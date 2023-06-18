//
//  CryptobitesApp.swift
//  Cryptobites
//
//  Created by VENOM on 3/23/23.
//

import SwiftUI

@main
struct CryptobitesApp: App {
    @State private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView().navigationBarHidden(true)
                
            }.environmentObject(vm)
        }
    }
}
