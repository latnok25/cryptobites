//
//  NetworkingManager.swift
//  Cryptobites
//
//  Created by VENOM on 3/25/23.
//

import Foundation
import Combine

class NetworkingManager {
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url).subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try HandleURLResponnnse(output: $0)})
                .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    enum NetworkingError: LocalizedError {
        case BadURLResponse
        case Unknown
        
        var errorDescription: String?{
            switch self{
            case.BadURLResponse: return "[🔥] Bad Response."
            case.Unknown: return "[‼️] Error Occured"
            }
        }
    }
    
    static func HandleURLResponnnse(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else{
            throw NetworkingError.BadURLResponse 
        }
        return output.data
    }
    
    static func HandleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case.finished:
            break
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}
