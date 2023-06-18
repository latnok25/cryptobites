//
//  CoinImageView.swift
//  Cryptobites
//
//  Created by VENOM on 3/25/23.
//

import SwiftUI


struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coinn:CoinModel){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coinn))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coinn:dev.coin)
    }
}
