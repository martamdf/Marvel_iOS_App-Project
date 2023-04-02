//
//  SeriesViewModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 30/3/23.
//

import Foundation
import Combine

final class SeriesViewModel: ObservableObject {
    @Published var series: [SerieResult]?
    @Published var hero : Hero?
    @Published var status = Status.none
    
    var suscriptors = Set<AnyCancellable>()
    var interactor : SeriesInteractorProtocol
    
    init(testing:Bool = false, hero:Hero, interactor: SeriesInteractorProtocol = SeriesInteractor()){
        self.interactor = interactor
        self.hero = hero
        if (testing){
            getSerieTesting()
        } else{
            getSeries(hero: hero)
        }
    }
    
    func getSeries(hero: Hero){
        self.status = .loading
        interactor.getSeries(hero: hero)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = Status.error(error: "Error buscando heroes")
                case .finished:
                    self.status = .none
                }
            } receiveValue: { data in
                self.series = data.data.results
                self.status = .none
            }
            .store(in: &suscriptors)

    }
    
    // UI Desing
    func getSerieTesting(){
        let hero1 = Hero(id: 1, name: "Heroe 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1))
        
        let serie1 = SerieResult(id: 1, title: "Serie 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))
        
        let serie2 = SerieResult(id: 1, title: "Serie 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"))

        self.hero = hero1
        self.series = [serie1, serie2]
    }
}
