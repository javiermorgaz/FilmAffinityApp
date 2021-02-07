//
//  FilmAffinityAPI.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 31/12/20.
//

import Foundation

enum FilmAffinityAPILang: String {
    case es
    case en
}

enum FilmAffinityAPI: ApiRouter {

    case detail(id: String, lang: FilmAffinityAPILang)

    var httpMethod: String {

        switch self {
        case .detail: return "GET"
        }
    }
    
    internal var baseUrl: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .detail: return "\(baseUrl)/detail/"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .detail(let id, let lang): return [
            URLQueryItem(name: "lang", value: lang.rawValue),
            URLQueryItem(name: "id", value: id)]
        }
    }
    
    func asURLRequest() -> URLRequest {
        var components = URLComponents(string: path)
        components?.queryItems = queryItems

        var urlRequest = URLRequest(url: (components?.url)!)
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue(Constants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        urlRequest.addValue("filmaffinity-unofficial.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

        return urlRequest
    }
}
