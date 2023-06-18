//
//  CoinImageService.swift
//  Cryptobites
//
//  Created by VENOM on 3/25/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image : UIImage? = nil
    
    private var ImageSubscription : AnyCancellable?
    private let Coin: CoinModel
    private let filemanager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.Coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let Savedimage = filemanager.getImage(imageName: imageName, folderName: folderName) {
            image = Savedimage
            
        }else{
            downloadCoinImage()
            
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: Coin.image)else{
            return
        }
        
        ImageSubscription = NetworkingManager.download(url: url)
            .tryMap({
                (data) -> UIImage? in return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.HandleCompletion(completion:), receiveValue: {[weak self] (returnnedImage) in
                guard let self = self, let downloadedImage = returnnedImage else{return}
        self.image = downloadedImage
        self.ImageSubscription?.cancel()
                self.filemanager.SaveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
    })
    }
}
