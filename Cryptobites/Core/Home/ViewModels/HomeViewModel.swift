//
//  HomeViewModel.swift
//  Cryptobites
//
//  Created by VENOM on 3/24/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var SaerchText: String = ""
    
    private let dataService = CoinDataService()
    private var Cancellable = Set<AnyCancellable>()
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            addSubscribers()
        }
        
        func addSubscribers(){
            
            //updates all coins
            $SaerchText
                .combineLatest (dataService.$allCoins)
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .map (filterCoins).sink{
                    [weak self] (returnedCoins) in
                    self?.allCoins = returnedCoins
                }.store(in: &Cancellable)
        }
        
         func filterCoins (text: String, coins: [CoinModel]) -> [CoinModel] {
            guard !text.isEmpty else{
                return coins
            }
            let lowercasedText = text.lowercased()
            
            return coins.filter { (coin) -> Bool in
                return coin.name.lowercased ().contains (lowercasedText) ||
                coin.symbol.lowercased().contains (lowercasedText) ||
                coin.id.lowercased() .contains(lowercasedText)
            }
        }
    }
}
