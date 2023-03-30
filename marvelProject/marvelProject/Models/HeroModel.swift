//
//  HeroModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation

/*
struct Heros: Codable, Identifiable {
    var id:UUID
    var name: String
    var description: String
    var photo: String
    var favorite: Bool?
}*/


// MARK: - Welcome
struct Hero: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: Thumbnail
    //let resourceURI: String
    //let comics, series: Comics
    //let stories: Stories
    //let events: Comics
    //let urls: [URLElement]
}

// MARK: - InitialData
struct Body: Codable{
    let code: Int
    let status: String
    let data: Data
}

struct Data: Codable{
    let results: [Hero]
}


// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
