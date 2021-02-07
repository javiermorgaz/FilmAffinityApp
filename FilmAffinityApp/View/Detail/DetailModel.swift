//
//  DetailModel.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 6/2/21.
//

import Foundation

class DetailModel {
    
    let id, title: String
    let link: String
    let director: [String]
    let country: String
    let excerpt: String
    let genres: [String]
    let actors: [String]
    let duration: String
    let lang: String
    let rating: String
    let votes: String
    let year: String
    let image: URL?
    let trailer: String
    
    init(_ movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.link = movie.link
        self.director = movie.director
        self.country = movie.country
        self.excerpt = movie.excerpt
        self.genres = movie.genres
        self.actors = movie.actors
        self.duration = movie.duration
        self.lang = movie.lang
        self.rating = String(describing: movie.rating)
        self.votes = String(describing: movie.votes)
        self.year = String(describing: movie.year)
        self.image = URL(string: movie.images.first ?? "")
        self.trailer = movie.trailer
    }
}
