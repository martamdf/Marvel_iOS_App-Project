//
//  BaseNetwork.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation

struct HTTPMethods {
    static let get = "GET"
    static let post = "POST"
    static let content = "application/json"
}

enum endpoints : String {
    
    case heroesList = "/v1/public/characters"
    
}


struct BaseNetwork {

    //lista de heroes
    func getSessionHeroes() -> URLRequest{
        let urlcad : String = "\(server)\(endpoints.heroesList.rawValue)?ts=\(Keys.ts)&apikey=\(Keys.publicKey)&hash=\(Keys.hash)"

        /*
        var urlComponents = URLComponents(url: URL(string: urlcad)!, resolvingAgainstBaseURL: true)
        
        let queryItems = [URLQueryItem(name: "ts", value: Keys.ts),
                          URLQueryItem(name: "apykey", value: Keys.publicKey),
                          URLQueryItem(name: "hash", value: Keys.hash)
        ]
        
        urlComponents?.queryItems = queryItems*/
        
        var request : URLRequest = URLRequest(url: URL(string: urlcad)!)
        request.httpMethod = HTTPMethods.get

        //request.httpBody = try? JSONEncoder().encode(HerosFilter(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")

        return request
    }

}
