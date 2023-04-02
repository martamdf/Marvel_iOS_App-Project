//
//  BaseNetwork.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation

let server = "https://gateway.marvel.com"

struct HTTPMethods {
    static let get = "GET"
    static let post = "POST"
    static let content = "application/json"
}

enum endpoints : String {
    case heroesList = "/v1/public/characters"
}


struct BaseNetwork {

    // Heroes
    func getSessionHeroes() -> URLRequest{
        let urlcad : String = "\(server)\(endpoints.heroesList.rawValue)?ts=\(Keys.ts)&apikey=\(Keys.publicKey)&hash=\(Keys.hash)"
        
        var request : URLRequest = URLRequest(url: URL(string: urlcad)!)
        request.httpMethod = HTTPMethods.get

        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")

        return request
    }
    
    // Series
    func getSessionSeries(hero: Hero) -> URLRequest{
        let idHeroe = hero.id
        
        let urlcad : String = "\(server)\(endpoints.heroesList.rawValue)/\(idHeroe)/series?ts=\(Keys.ts)&apikey=\(Keys.publicKey)&hash=\(Keys.hash)"

        var request : URLRequest = URLRequest(url: URL(string: urlcad)!)
        request.httpMethod = HTTPMethods.get

        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")

        return request
    }
    

}
