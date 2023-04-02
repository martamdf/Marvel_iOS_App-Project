//
//  HeroModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation

// MARK: - Welcome
struct Hero: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: Thumbnail
    let series: Series
}

// MARK: - InitialData
struct Body: Codable{
    let code: Int
    let status: String
    let data: Data
}

// MARK: - Data
struct Data: Codable{
    let results: [Hero]
}

// MARK: - Series/

struct Series: Codable {
    let available: Int
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

// MARK: - Welcome Series
struct Welcome: Codable {
    let code: Int
    let data: DataClass
}

// MARK: - DataClass Series
struct DataClass: Codable {
    let results: [SerieResult]
}

// MARK: - Result Series
struct SerieResult: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

