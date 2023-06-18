//
//  CoinRowPreview.swift
//  Cryptobites
//
//  Created by VENOM on 3/24/23.
//

import SwiftUI

struct CoinRowPreview: View {
    
    let coin: CoinModel
    let ShowHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
           leftColumn
            Spacer()
            if ShowHoldingColumn{
               centerColumn
            }
            rightColumn
        }.font(.subheadline)
    }
}

struct CoinRowPreview_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowPreview(coin: dev.coin, ShowHoldingColumn: true)
    }
}

extension CoinRowPreview{
    private var leftColumn : some View {
        HStack(spacing: 0){
            
            Text("\(coin.Rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coinn: coin).frame(width:30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.CurrenntHoldingsValue.AsCurrencyWithDecimals2())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coin.currentHoldings ?? 0).AsNumberString())
            
                .foregroundColor( Color.theme.accent)
        }
    }
    private var rightColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.AsCurrencyWithDecimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.AsPercentString() ?? "0.00%")
            
                .foregroundColor(coin.priceChangePercentage24H ?? 0.00 >= 0 ? Color.theme.green : Color.theme.red)
        }.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
