//
//  marvelProjectTests.swift
//  marvelProjectTests
//
//  Created by Marta Maquedano on 29/3/23.
//

import XCTest
import Combine
import SwiftUI
@testable import marvelProject
import ViewInspector


final class marvelProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testErrorView() throws {
        let view = ErrorView(error: "Testing")
            .environmentObject(RootViewModel())
        
        XCTAssertNotNil(view)
        
        //Numero de elementos
        let numItems = try view.inspect().count //devuelve el númro de vistas
        XCTAssertEqual(numItems, 1)
        
        //Imagen de error
        let img = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(img) //controlar que no se hayan eliminado imágenes
        
        // Texto
        let text = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(text)
        let texto = try text.text().string()
        XCTAssertEqual(texto, "Testing")
        
        //Button
        let boton = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(boton)
        try boton.button().tap()
        
        //Testing de modelos


        
    
    func testHeroView() throws {
        let view = HeroesView(viewModel: HeroViewModel(testing: true))
        
        // Se construye correctamente
        XCTAssertNotNil(view)

        //Numero de elementos
        let numItems = try view.inspect().count //devuelve el númro de vistas
        XCTAssertEqual(numItems, 1)
        
        //TEST ASÍNCRONO DE COMBINE
        func testViewModelHeroes() throws {
            var suscriptor = Set<AnyCancellable>()
            let expectation = self.expectation(description: "Descarga de Bootcamps")
            
            //Instanciamos el viewModel
            let vm = RootViewModel(testing:false) // true con el testing mockeado
            XCTAssertNotNil(vm)
            
            //OBservador de los Bootcamps
            vm.heroes.publisher
                .sink { completion in
                    switch completion {
                    case .finished:
                        XCTAssertEqual(1, 1)
                        expectation.fulfill()
                    case .failure:
                        XCTAssertEqual(1, 2)
                        expectation.fulfill()
                    }
                    
                }receiveValue: { datos in
                    // recibimos los datos
                }
                .store(in: &suscriptor)
            
            // Lanzamos la carga de Heroes
            vm.LoadHeroes()

            // ahora hay que decirle que espere, porque si no no va a terminar
            self.waitForExpectations(timeout: 10)
        }
        
        //Testing de los Heroes
        func testHerosLoad() throws {
            var suscriptor = Set<AnyCancellable>()
            let expectation = self.expectation(description: "Heroes FAKE")
            
            //instanciamos el view model
            let vm = HeroViewModel()//(interactor: HerosInteractorTesting()) //inyectamos el interactor fake
            XCTAssertNotNil(vm)
            //Observador de los heroes
            vm.heroes.publisher
                .sink { completion in
                    switch completion{
                    case .failure:
                            print("Error")
                            XCTAssertEqual(1,2) // Forzamos Fallo
                            expectation.fulfill()
                    case .finished:
                        print ("finish ok")
                    }
                } receiveValue: { data in
                    XCTAssertEqual(data.count, 2)
                    expectation.fulfill()
                }
                .store(in: &suscriptor)
            self.waitForExpectations(timeout: 10) //esperamos 10 segundos
        }
    }
    
    func testHeroDetailView() throws {
        let view = HeroDetailView(viewModel: SeriesViewModel(testing: true, hero: Hero(id: 1, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1))))
        
        // Se construye correctamente
        XCTAssertNotNil(view)

        //Numero de elementos
        let numItems = try view.inspect().count // Número de Vistas
        XCTAssertEqual(numItems, 1)
        
        let heroName = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(heroName)
        
        //TEST ASÍNCRONO DE COMBINE
        func testSeriesViewModel() throws {
            var suscriptor = Set<AnyCancellable>()
            let expectation = self.expectation(description: "Series")
            
            //Instanciamos el viewModel
            let vm = SeriesViewModel(testing:true, hero: Hero(id: 1, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1)))
            
            XCTAssertNotNil(vm)
            
            vm.hero.publisher
                .sink { completion in
                    switch completion {
                    case .finished:
                        XCTAssertEqual(1, 1)
                        expectation.fulfill()
                    case .failure:
                        XCTAssertEqual(1, 2)
                        expectation.fulfill()
                    }
                }receiveValue: { datos in
                    XCTAssertEqual(datos.name, "Goku")
                    expectation.fulfill()
                }
                .store(in: &suscriptor)
            
            vm.series.publisher
                .sink { completion in
                    switch completion {
                    case .finished:
                        XCTAssertEqual(1, 1)
                        expectation.fulfill()
                    case .failure:
                        XCTAssertEqual(1, 2)
                        expectation.fulfill()
                    }
                    
                }receiveValue: { datos in
                    XCTAssertEqual(datos.count, 1)
                    expectation.fulfill()
                }
                .store(in: &suscriptor)

            vm.getSerieTesting()
            
            self.waitForExpectations(timeout: 10)
        }
        
        //Testing de los Heroes
        func testSeriesLoad() throws {
            var suscriptor = Set<AnyCancellable>()
            let expectation = self.expectation(description: "Heroes")
            
            //instanciamos el view model
            let vm = SeriesViewModel(hero:Hero(id: 1, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 2)))//(interactor: HerosInteractorTesting()) //inyectamos el interactor fake
            
            XCTAssertNotNil(vm)
            
            //Observador de las series
            vm.series.publisher
                .sink { completion in
                    switch completion{
                    case .failure:
                            print("Error")
                            XCTAssertEqual(1,2) // Forzamos el fallo
                            expectation.fulfill()
                    case .finished:
                        print ("Finished")
                    }
                } receiveValue: { data in
                    XCTAssertEqual(data.count, 2)
                    expectation.fulfill()
                }
                .store(in: &suscriptor)
            self.waitForExpectations(timeout: 10) //esperamos 10 segundos
        }
    }

    }
    func testHeroDetailRowView() throws {
        let view = HeroDetailRowView(serie: SerieResult(id: 1, title: "Avengers", description: "Avengers Description", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")))
        
        // Se construye correctamente
        XCTAssertNotNil(view)

        //Numero de elementos
        let numItems = try view.inspect().count
        XCTAssertEqual(numItems, 1)
        
        let seriePhoto = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(seriePhoto)
        
        let serieTitle = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(serieTitle)
        
        let serieDescription = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(serieDescription)

    }
    
    
    func testModels() throws {
        let hero = Hero(id: 1, name: "Marta", description: "Descripcion", modified: "12/12/2022", thumbnail: Thumbnail(path: "una URL con la imagen", thumbnailExtension: "jpg"), series: Series(available: 1))
        
        XCTAssertNotNil(hero) // Comprobamos que se puede construir
        XCTAssertEqual(hero.name, "Marta")
        XCTAssertEqual(hero.modified, "12/12/2022")
        
        let serie1 = SerieResult(id: 1, title: "Una serie", description: "Descripcion", thumbnail: Thumbnail(path: "una URL con la imagen", thumbnailExtension: "jpg"))
        
        XCTAssertNotNil(serie1) // Comprobamos que se puede construir
        XCTAssertEqual(serie1.title, "Una serie")
        XCTAssertEqual(serie1.description, "Descripcion")
        XCTAssertEqual(serie1.thumbnail.thumbnailExtension, "jpg")
    }
}

