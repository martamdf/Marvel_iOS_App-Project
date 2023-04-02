//
//  HeroesInteractor.swift
//  marvelProject
//
//  Created by Marta Maquedano on 1/4/23.
//

import Foundation
import Combine

//protocolo
protocol HeroesInteractorProtocol: AnyObject {
    func getHeroes() ->AnyPublisher<Body, Error>
}

// Clase ineractor real
final class HeroesInteractor: HeroesInteractorProtocol {
    let networker: NetworkerProtocol
    let baseNetWork: BaseNetwork
    
    init(network: NetworkerProtocol = NetWorker(), baseNetwork: BaseNetwork = BaseNetwork()){
        self.networker = network
        self.baseNetWork = baseNetwork
    }
    
    func getHeroes() ->AnyPublisher<Body, Error>{
        return networker.callServer(type: Body.self, request: baseNetWork.getSessionHeroes())
    }
}

// Clase ineractor testing
final class HeroesInteractorTesting:HeroesInteractorProtocol {

    func getHeroes() ->AnyPublisher<Body, Error> {
        let hero1 = Hero(id: 1, name: "Goku", description: "", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1))
        
        let body = Body(code: 200, status: "OK", data:Data(results: [hero1]))

        //convierto en publicador
        let publisher = CurrentValueSubject<Body, Error>(body)
        return publisher.eraseToAnyPublisher()
    }
}
