//
//  Film.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 31/12/20.
//

import Foundation

struct MovieResponse: Codable {
    let movie: Movie
}

struct Movie: Codable {
    let id, title: String
    let link: String
    let director: [String]
    let country: String
    let excerpt: String
    let genres: [String]
    let actors: [String]
    let duration: String
    let lang: String
    let rating: Int
    let votes: Int
    let year: Int
    let images: [String]
    let trailer: String
}
//
//struct MovieResponse: Codable {
//    let content: [Content]
//    let status: Bool
//}
//
//struct Content: Codable {
//    let actors: [Actor]
//    let awards: [Award]
//    let country: String
//    let critics: [Critic]
//    let directors: [Actor]
//    let duration: String
//    let genres: [Actor]
//    let guionists: [String]
//    let id: Int
//    let images: [String: [String]]
//    let musicians: [String]
//    let name: String
//    let photography, producer: [String]
//    let rating: Rating
//    let spanishName, summary: String
//    let trailers: [String]
//    let url: String
//    let year: String
//
////    enum CodingKeys: String, CodingKey {
////        case actors, awards, country, critics, directors, duration, genres, guionists, id, images, musicians, name, photography, producer, rating
////        case spanishName
////        case summary, trailers, url, year
////    }
//}
//
//struct Actor: Codable {
//    let name: String
//    let url: String
//}
//
//struct Award: Codable {
//    let name: String
//    let url: String
//    let year: String
//}
//
//struct Critic: Codable {
//    let author, country: String
//    let gender: Gender
//    let media: String
//    let status: Status
//    let text: String
//    let url: String
//}
//
//enum Gender: String, Codable {
//    case f = "F"
//    case m = "M"
//}
//
//enum Status: String, Codable {
//    case neu = "NEU"
//    case pos = "POS"
//}
//
//struct Rating: Codable {
//    let critics: Int
//    let note: Double
//}
