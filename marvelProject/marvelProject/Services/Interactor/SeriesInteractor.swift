//
//  SeriesInteractor.swift
//  marvelProject
//
//  Created by Marta Maquedano on 2/4/23.
//

import Foundation
import Combine

//protocolo
protocol SeriesInteractorProtocol: AnyObject {
    func getSeries(hero: Hero) ->AnyPublisher<Welcome, Error>
}

// Clase ineractor real
final class SeriesInteractor: SeriesInteractorProtocol {
    let networker: NetworkerProtocol
    let baseNetWork: BaseNetwork
    
    init(network: NetworkerProtocol = NetWorker(), baseNetwork: BaseNetwork = BaseNetwork()){
        self.networker = network
        self.baseNetWork = baseNetwork
    }
    
    func getSeries(hero: Hero) ->AnyPublisher<Welcome, Error>{
        return networker.callServer(type: Welcome.self, request: baseNetWork.getSessionSeries(hero: hero))
    }
}

// Clase ineractor testing
final class SeriesInteractorTesting:SeriesInteractorProtocol {

    func getSeries(hero: Hero) ->AnyPublisher<Welcome, Error> {
        let serie1 = SerieResult(id: 1, title: "Serie 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))

        let serie2 = SerieResult(id: 2, title: "Serie 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))
        
        let series = [serie1, serie2]
        
        let welcome = Welcome(code: 200, data: DataClass(results: series))
        
        //convierto en publicador
        let publisher = CurrentValueSubject<Welcome, Error>(welcome)
        return publisher.eraseToAnyPublisher()
    }
}
