//
//  CoinDataService.swift
//  Cryptobites
//
//  Created by VENOM on 3/24/23.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription : AnyCancellable?
    
    init() {
        getcoins()
    }
    
    private func getcoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")else{
            return
        }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.HandleCompletion(completion:), receiveValue: {[weak self] (returnnedCoins) in
        
        self?.allCoins = returnnedCoins
        self?.coinSubscription?.cancel()
    })
    }
    
}
