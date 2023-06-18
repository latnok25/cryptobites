//
//  SearchBarView.swift
//  Cryptobites
//
//  Created by VENOM on 3/25/23.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var SearchText: String

    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass").foregroundColor(
                SearchText.isEmpty ?
                Color.theme.secondaryText : Color.theme.accent)
            TextField("Search by name or Symbol.... ", text: $SearchText).foregroundColor(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.accent)
                        .offset(x: 10)
                        .padding()
                        .opacity(SearchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing() 
                            SearchText = ""
                        },
                    alignment: .trailing
                )
        }.font(.headline)
            .padding()
            .background(RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x:0, y: 0)).padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(SearchText: .constant(""))
    }
}
