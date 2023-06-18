//
//  ContentView.swift
//  Cryptobites
//
//  Created by VENOM on 3/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 40) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(Color.theme.red)
                Text("Hello, world!").foregroundColor(Color.theme.accent)
                Text("Red").foregroundColor(Color.theme.red)
                Text("Green").foregroundColor(Color.theme.green)
                Text("Seconndary").foregroundColor(Color.theme.secondaryText)
            }
            .padding()
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
