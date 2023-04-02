//
//  RootViewModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status:Status = Status.none
    
    @Published var heroes : [Hero]? 
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing:Bool=false) {
        if !testing {
            self.LoadHeroes()
        } else {
            self.LoadHeroesTesting()
        }
    }
    
    func LoadHeroes(){
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeroes())
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                   
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: [Hero].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let errStr):
                    print(errStr)
                case .finished:
                    print("Finalizada carga Heroes")
                }
                
            } receiveValue: { data in
                self.heroes  = data
            }
            .store(in: &suscriptors)
    }
    
    func LoadHeroesTesting() -> Void {
        let h1 =  Hero(id: 1, name: "Heroe 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1))

        let h2 =  Hero(id: 2, name: "Heroe 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", modified: "12/12/2021", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 2))


        self.heroes = [h1,h2]
    }
}


