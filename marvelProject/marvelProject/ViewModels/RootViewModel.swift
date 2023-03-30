//
//  RootViewModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation
import Combine


final class RootViewModel: ObservableObject {
    @Published var status:Status = Status.none // estado del login
    @Published var heroes : [Hero]? //
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing:Bool=false) {
        //self.LogedUserControl() //control de session
        
        if !testing {
            self.LoadHeroes()
        } else {
            //testing...
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
                
                //Login OK
                return $0.data
            }
            .decode(type: [Hero].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let errStr):
                    print(errStr)
                case .finished:
                    print("Finalizada carga de bootcamps")
                }
                
            } receiveValue: { data in
                self.heroes  = data
            }
            .store(in: &suscriptors)

    }
    
    
    func LoadHeroesTesting() -> Void {
        let b1 =  Hero(id: 1, name: "heroeee 12", description: "descripción", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))
        let b2 =  Hero(id: 2, name: "otro hero 1", description: "otra cesf", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))

        self.heroes = [b1,b2]
    }
}


